PgpIo::App.controllers  do
  layout :main

  get :index do
    render :index
  end
  
  get :about do
    render :about
  end

  post :m do
    @msg = Message.new
    # TODO: Validate text param
    @msg.text = params[:text]
    @msg.save

    # TODO: Use a url_for here. Can't remember the syntax.
    redirect "/m/#{@msg.id}"
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
