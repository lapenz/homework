class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new

    super
  end

  # POST /resource/sign_in
  def create
#byebug
    idAluno = params[:user][:username].sub("aluno", "") if !sign_in_params.nil?
    if idAluno.to_i > 0
      aluno = Aluno.find(idAluno)
      email = aluno.email
      email = params[:user][:username] + "@athus.com.br" if email.empty?
      User.where(id: aluno.id).update_or_create(id: aluno.id, name: aluno.nome, email: email, username: params[:user][:username], password: aluno.codigo, password_confirmation: aluno.codigo, role: 'student', approved: true) if !aluno.nil?
    end
    #byebug
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected
    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:role])
    end
end
