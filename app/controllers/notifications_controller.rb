class NotificationsController < ApplicationController  
  def show
    @notification = Notification.new
  end

  def new
    @notification = Notification.new(

      # Development
      # certificate: File.join(Rails.root, 'config/certs', 'viply_staging_aps_development.pem'),
      # passphrase: '6f--FEj+&PCVkAR5hVsB',
      # gateway: 'gateway.sandbox.push.apple.com',
      # device_token: 'e7d8dc84f694f11cfa20353bcb7bb02f9b000413c37da274035b6b08235c1d0e',

      # Production
      certificate: File.join(Rails.root, 'config/certs', 'viply_staging_aps_production.pem'),
      passphrase: 'x+zw3HpFA#AF&9D7bVK*',
      gateway: 'gateway.push.apple.com',
      device_token: '8790ea61ee3b4b43b7aa8d412d77ed20e997cc8938e9895d0b529d1d031c6cd0',

      alert: 'test'
    )
  end

  def create
    @notification = Notification.new(notification_params)

    # Grocer
    pusher = Grocer.pusher(
      certificate: @notification.certificate,
      passphrase:  @notification.passphrase,
      gateway: @notification.gateway
    )
    notification = Grocer::Notification.new(
      device_token: @notification.device_token,
      alert:        @notification.alert,
      badge:        1
    )
    @notification.bytes_sent = pusher.push(notification)

    render action: :show
  end

  private

  def notification_params
    params.require(:notification).permit(:certificate, :passphrase, :gateway, :device_token, :alert)
  end
end
