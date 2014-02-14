class SessionsController < ApplicationController
  def new

  end

  def create
  	user = User.find_by(login: params[:session][:login].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      if User::Nivel::SUPERVISOR 
        redirect_to summary_city_path
      else
        redirect_to item_advances_path
      end
    else
      #flash.now[:danger] = 'Nome ou senha invalido' # Not quite right!
      #render controller: 'sessions', action: 'new'
      redirect_to root_url, flash: { :danger => "Nome ou senha invalido" } 
    end
  end

  
  def destroy
    sign_out
    redirect_to root_url
  end
end
