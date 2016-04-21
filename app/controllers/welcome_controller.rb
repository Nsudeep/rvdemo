class WelcomeController < ApplicationController
  def index
    token = request.headers['AuthToken']
    rsa_public = OpenSSL::PKey::RSA.new File.read '../key_final.pub'
    decoded_token = JWT.decode token, rsa_public, true, { :algorithm => 'RS256' } rescue -1
    puts "\n\n\n\n\nToken: #{token}\n\nrsa_public: \n#{rsa_public}\n\ndecoded_token: #{decoded_token}\n\n"
    if decoded_token
      render :json => {
      :message => "All good. You only get this message if you're authenticated.",
      :token => token
      }
    else
      render :json => {
      message: 'Wrong Authenticaion.',
      token: 'Wrong Authentication. Hence, token not sent'
      }
    end
  end
end
