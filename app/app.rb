# Bring in lib dir
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each do |file|
  require file
end

module PgpIo
  ROOT = ::File.expand_path('..', __FILE__)

  class App < Sinatra::Application

    enable :sessions
    set :session_secret, ENV['SESSION_SECRET'] || 'Not a good secret.'
    set :protection, :except => :path_traversal
    set :protect_from_csrf, true
    set :views, 'app/views'

    # http://github.com/kelredd/rack-less
    use Rack::Less, :root => ROOT, :source => 'app/css', :public => 'public', :hosted_at => 'css'

    helpers do
      include Rack::Utils
      alias_method :h, :escape_html
    end

    configure :production do
      set :clean_trace, true
      Rack::Less.configure do |config|
        config.compress = true
      end
    end

    configure :development do
      Rack::Less.configure do |config|
        config.compress = false
      end
    end

    error 404 do
      render 'errors/404'
    end

    require File.dirname(__FILE__) + '/controllers.rb'
    Dir[File.dirname(__FILE__) + '/models/*.rb'].each do |file|
      require file
    end
  end
end
