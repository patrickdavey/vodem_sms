module VodemSms
  module Headers
    WEBSERVER_SET_CMD_URL    = "http://192.168.9.1/goform/goform_set_cmd_process"
    WEBSERVER_GET_CMD_URL    = "http://192.168.9.1/goform/goform_get_cmd_process"

    AGENT_HEADER = "User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:37.0) Gecko/20100101 Firefox/37.0'" 
    CONTENT_TYPE_HEADER = 'application/x-www-form-urlencoded; charset=UTF-8'
    CACHE_CONTROL_HEADER = 'no-cache'
    CONNECTION_HEADER = 'keep-alive'
    ENCODING_HEADER = 'gzip, deflate'
    LANGUAGE_HEADER= "en-US,en;q=0.5"
    PRAGMA_HEADER = 'no-cache'
    REFERRER_HEADER = 'http://192.168.9.1/home.htm'
    WEBSERVER_HOST_HEADER    = "192.168.9.1"
    X_REQUESTED_WITH_HEADER = 'XMLHttpRequest'
  end
end
