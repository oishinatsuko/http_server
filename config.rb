# -*- coding: utf-8 -*-

# 表示する対象のフォルダパス
@base_path = "/home/natsuko/workspace/oishi/www"
# エラーファイルのフォルダパス
@error_path = "/home/natsuko/workspace/oishi/www/errors"
# ログフォルダパス
@log_path = "/home/natsuko/workspace/oishi/log"

$config = Hash.new
instance_variables.each {|name|
  $config[name[1..-1].to_sym] = instance_variable_get(name)
}

