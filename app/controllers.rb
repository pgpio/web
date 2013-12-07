PgpIo::App.controllers  do
  layout :main

  get :index do
    render :index
  end
  
  get :about do
    render :about
  end

  post :m, :provides => [:any, :js] do
    case content_type
    when :js then
      ret
    else
    end
  end

  # Maps to url "/m/#{params[:id]}"
  get :m, :with => :id do
    begin
      @msg = Message.get(params[:id])
      render @msg.text
    rescue
      404
    end
  end
end
