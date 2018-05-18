Pod::Spec.new do |s|
  s.name         = 'TrustWalletSDK'
  s.version      = '0.0.1'
  s.summary      = 'Trust Wallet SDK.'
  s.homepage     = 'https://github.com/TrustWallet/TrustSDK-iOS'
  s.authors      = { 'Alejandro Isaza' => 'al@isaza.ca', 'Viktor Radchenko' => 'yazexel@gmail.com' }

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'

  s.source       = { git: 'https://github.com/TrustWallet/TrustSDK-iOS.git', tag: s.version }
  s.source_files = 'Sources/TrustWalletSDK/**/*.{swift}'

  s.dependency 'TrustCore'
end
