class PgpIo::App < Sinatra::Application
  get "/" do
    erb :index, :layout => :'layouts/main'
  end
  
  get "/about" do
    erb :about, :layout => :'layouts/main'
  end

  # Append to a location
  # This string could also be %r{/m/[a-zA-Z0-9]\{1,32\}}
  post "/m/:id" do
    text = params[:text]
    if text.nil? || text.empty?
      text = request.body.read
    end

    raise "Text is empty." if text.empty?
    raise "Text is not valid Ascii Armored message." if !AsciiArmor.valid? text

    @msg = Message.get(params[:id])
    @msg.append(text.strip)
    @msg.save

    keen_log :append, {:msg_id => params[:id]}

    redirect "/m/#{@msg.id}"
  end

  post %r{/m/?} do
    text = params[:text]
    if text.nil? || text.empty?
      text = request.body.read
    end

    raise "Text is empty." if text.empty?
    raise "Text is not valid Ascii Armored message." if !AsciiArmor.valid? text

    @msg = Message.new
    @msg.text = text.strip
    @msg.save

    keen_log :post, {:msg_id => @msg.id}

    redirect "/m/#{@msg.id}"
  end

  # Maps to url "/m/#{params[:id]}"
  get "/m/:id" do
    begin
      @msg = Message.get(params[:id])

      keen_log :get, {:msg_id => @msg.id}

      if params[:plain]
        content_type 'text/plain;charset=utf8'
        @msg.text
      else
        erb :message, :layout => :'layouts/main'
      end
    end
  end
end
