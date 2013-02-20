# -*- coding: utf-8 -*-

class Error
  File = {
    "404 Not Found"             => "/404.html",
    "500 Internal server error" => "/500.html"
  }
  
  class NotFoundFileException < Exception
  end

end
