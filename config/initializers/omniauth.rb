Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "309363909097151", "dbac439fc9ab2cbbcb71069bcf99bde4"
end