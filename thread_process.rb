# -*- coding: utf-8 -*-

class ThreadProcess
  def initialize(socket, request)
    @socket= socket
    @request = request
  end
  
  def run
    begin
      return_response
    rescue Error::NotFoundFileException => e
      p e.message
      $log.puts(e.message)
      return_response(HttpContent::Status["not_found"], true)
    rescue Exception => e
      p e.message
      $log.puts(e.message)
      return_response(HttpContent::Status["internal_error"], true)
    end
  end

  private
  
  # ファイルを表示する
  # エラーの場合にはエラーファイルを表示する
  def return_response(status = HttpContent::Status["ok"], is_error = false)
    file_path = is_error ? Error::File["#{status}"] : @request[1]
    size, content, type = getFile(file_path, is_error)
    
    log_puts(type, status)
    @socket.write HttpContent.content(@request, status, type, content, size)
  end
  
  # ファイル情報を取得
  # ファイルが存在する場合にはファイル内容とサイズ、ContentTypeを返し、存在しない場合にはエラーを投げる
  def getFile(path, is_error = false)
    _path = (is_error ? $config[:error_path] : $config[:base_path]) + path
    if FileTest.exist?(_path) && File.file?(_path)
      content = open(_path) do |f|
        f.read
      end
      size = File.size _path
      type = HttpContent.type(_path)
      return size, content, type
    else
      p "not found file #{_path}"
      $log.puts("not found file #{_path}")
      raise Error::NotFoundFileException
    end
  end

  # ログ出力
  def log_puts(type, status)
    $log.puts "----------------------"
    $log.puts Time.now.strftime("%Y-%m-%d %H:%M:%S")
    $log.puts "Request_URL: #{@request[1]}"
    $log.puts "Request method: #{@request[0]}"
    $log.puts "ContentType: #{type}"
    $log.puts "AcceptType: #{type}"
    $log.puts "Response: #{status}"
  end
  
end
