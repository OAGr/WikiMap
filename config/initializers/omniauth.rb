if Rails.env == 'development' || Rails.env == 'test'
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "203758613046153", "2d14bb7b20eb82ce5c88367425548509"
  end
else
  # Production
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "309363909097151", "dbac439fc9ab2cbbcb71069bcf99bde4"
  end
end

