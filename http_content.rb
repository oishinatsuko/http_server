# -*- coding: utf-8 -*-
class HttpContent
  # 拡張子とContent-Typeの対応表
  Type = {
    ".html" => "text/html",   ".txt"   => "text/plain",
    ".jpg"  => "image/jpeg",  ".jpeg"  => "image/jpeg",
    ".gif"  => "image/gif",   ".png"   => "image/png", 
    ".mp3"  => "audio/mpeg",  ".mid"   => "audio/midi", 
    ".css"  => "text/css",    ".xhtml" => "application/xhtml+html", 
    ".svg"  => "image/svg+xml"
  }

  Status = {
    "ok"             => "200 OK",
    "not_found"      => "404 Not Found",
    "internal_error" => "500 Internal server error"
  }
  
  # 必要なものの確認、準備
  def self.setting
    # ログファイル設定
    $log = File.open($config[:log_path] + "/#{Date.today.strftime("%Y%m%d")}_server.log","a")
    
    self.check_file
  end
  
  # filenameの拡張子を見てContent-Typeを返す
  def self.type(path)
    content_type = Type[File.extname(path)]
    # Content-Typeが見つからなかったらtext/htmlを設定
    if content_type == nil
      content_type = "text/html"
    end
    content_type
  end
  
  # 表示させるhttpの内容
  def self.content(request, status, type, content, size)
    <<EOF
#{request[2]} #{status}
Content-Type: #{type}; charset=UTF-8
Content-Length: #{size}

#{content}
EOF
  end
  
  # ディレクトリとエラーファイルの存在チェック
  # 存在しないものが設定されている場合にはエラーを投げる
  def self.check_file
    # ディレクトリチェック
    $config.each do |dir|
      unless File.exist?(dir[1])
        raise "not found directory #{dir[1]}"
      end
    end
    
    # エラーファイルチェック
    Error::File.each do |error_file|
      path = $config[:error_path] + error_file[1]
      unless File.exist?(path)
        raise "not found file #{path}"
      end
    end
  end
  
end
