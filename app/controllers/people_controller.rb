class PeopleController < ApplicationController

  # GET /people
  def index
    command_person_list = PersonServices::List.new
    define_behavior_to_broadcast(command_person_list, :successfully, :ok)
    command_person_list.call
  end

  # GET /people/1
  def show
    command_person_show = PersonServices::Show.new(params)
    define_behavior_to_broadcast(command_person_show, :successfully, :ok)
    define_behavior_to_broadcast(command_person_show, :not_found, :not_found)
    command_person_show.call
  end

  # POST /people
  def create
    command_person_create = PersonServices::Create.new(person_params)
    define_behavior_to_broadcast(command_person_create, :successfully, :created)
    define_behavior_to_broadcast(command_person_create, :failed, :bad_request)
    command_person_create.call
  end

  # PATCH/PUT /people/1
  def update
    command_person_update = PersonServices::Update.new(person_params)
    define_behavior_to_broadcast(command_person_update, :successfully, :ok)
    define_behavior_to_broadcast(command_person_update, :failed, :bad_request)
    define_behavior_to_broadcast(command_person_update, :not_found, :not_found)
    command_person_update.call
  end

  # DELETE /people/1
  def destroy
    command_person_destroy = PersonServices::Destroy.new(params)
    define_behavior_to_broadcast(command_person_destroy, :successfully, :no_content)
    define_behavior_to_broadcast(command_person_destroy, :failed, :bad_request)
    define_behavior_to_broadcast(command_person_destroy, :not_found, :not_found)
    command_person_destroy.call
  end

  private

  # Only allow a trusted parameter "white list" through.
  def person_params
    params.permit(:id, :name, :reason, :cnpj)
  end
end
