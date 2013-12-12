class PgpIo::App < Sinatra::Application
  get "/" do
    erb :index, :layout => :'layouts/main'
  end
  
  get "/about" do
    erb :about, :layout => :'layouts/main'
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

    redirect "https://pgp.io/m/#{@msg.id}"
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

    redirect "https://pgp.io/m/#{@msg.id}"
  end

  # Maps to url "/m/#{params[:id]}"
  get "/m/:id" do
    begin
      @msg = Message.get(params[:id])

      if params[:plain]
        content_type 'text/plain;charset=utf8'
        @msg.text
      else
        erb :message, :layout => :'layouts/main'
      end
    end
  end
end
