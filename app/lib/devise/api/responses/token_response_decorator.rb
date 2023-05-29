module Devise::Api::Responses::TokenResponseDecorator
  def body
    return default_body.merge({ role: resource_owner.class.to_s })
  end
end

