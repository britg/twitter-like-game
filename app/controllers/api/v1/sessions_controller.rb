class Api::V1::SessionsController < Devise::SessionsController

  def create
    if request.format.json?
      self.resource = warden.authenticate!
      sign_in(resource_name, resource)
      data = {
        token: resource.authentication_token,
        email: resource.email
      }
      render json: data, status: 201 and return
    else
      super
    end
  end

end
