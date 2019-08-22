class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  layout false

  def handle
    if request.headers['Content-Type'] == 'application/json'
      data = JSON.parse(request.body.read)
      p data
    else
      data = params.as_json
      p data
    end

    render nothing: true
  end

end


# data => {"action"=>"honor_changed", "user"=>{"id"=>"5a75ef91ba1bb5425b000124", "honor"=>194, "honor_delta"=>2}}
# params => <ActionController::Parameters {"action"=>"handle", "user"=>{"id"=>"5a75ef91ba1bb5425b000124", "honor"=>194, "honor_delta"=>2},
  # "controller"=>"webhooks", "webhook"=>{"action"=>"honor_changed", "user"=>{"id"=>"5a75ef91ba1bb5425b000124", "honor"=>194, "honor_delta"=>2}}} permitted: false>

# Parameters: {"webhook"=>{"id"=>"5d52efc490b24300131d7f0d"}}
# {"action"=>"updated", "webhook"=>{"id"=>"5d52efc490b24300131d7f0d"}}

