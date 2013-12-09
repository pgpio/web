class PgpIo::App < Sinatra::Application
  layout :main

  get "/" do
    erb :index
  end
  
  get "/about" do
    erb :about
  end

  post "/m" do
    text = params[:text].strip
    raise "Text is empty." if text.empty?
    raise "Text is not valid Ascii Armored message." if not AsciiArmor.valid? text

    @msg = Message.new
    @msg.text = text
    @msg.save

    redirect "/m/#{@msg.id}"
  end

  # Maps to url "/m/#{params[:id]}"
  get "/m/:id" do
    begin
      @msg = Message.get(params[:id])

      content_type 'text/plain;charset=utf8'
      @msg.text
    end
  end
end
