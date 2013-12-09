PgpIo::App.controllers  do
  layout :main

  get :index do
    render :index
  end
  
  get :about do
    render :about
  end

  post :m do
    text = params[:text].strip
    raise "Text is empty." if text.empty?
    raise "Text is not valid Ascii Armored message." if not AsciiArmor.valid? text

    @msg = Message.new
    @msg.text = text
    @msg.save

    redirect url_for(:m, :id => @msg.id)
  end

  # Maps to url "/m/#{params[:id]}"
  get :m, :with => :id do
    begin
      @msg = Message.get(params[:id])

      content_type 'text/plain;charset=utf8'
      @msg.text
    end
  end
end
