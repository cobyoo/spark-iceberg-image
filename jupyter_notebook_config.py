c = get_config()

c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8888  
c.ServerApp.open_browser = False  
c.ServerApp.allow_remote_access = True
c.ServerApp.token = ''
c.ServerApp.password = ''
c.ServerApp.trust_xheaders = True
c.ServerApp.allow_origin = '*'
c.ServerApp.disable_check_xsrf = True
c.ServerApp.root_dir = '/home/elicer'
c.ServerApp.tornado_settings = {
    'headers': {
        'Content-Security-Policy': "frame-ancestors 'self' https://*.elice.io *"
    }
}

