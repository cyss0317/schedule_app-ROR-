# frozen_string_literal: true

class OrganizationsController < ApplicationController
  def create
    @organization = Organization.create!(
      name: params['organization']['name'],
      street_address: params['organization']['street_address'],
      state: params['organization']['state'],
      city: params['organization']['city'],
      phone: params['organization']['phone']
    )

    if @organization
      render json: {
        status: :created,
        organization: @organization
      }
    else
      render json: { status: 500 }
    end

  end

  def update
    organization = Organization.find(params[:id])
    if organization&.update(organization_params)
      render json: {
        status: :updated,
        organization:
      }
    else
      render json: organization.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    organization = Organization.find(params[:id])

    if organization&.delete
      render json: {
        status: :deleted
      }
    else
      render json: organization.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :street_address, :state, :city, :phone)
  end
end
