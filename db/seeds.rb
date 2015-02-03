# coding: utf-8

puts 'Seeding the database...'

[
  { pt: 'Arte', en: 'Produce' },
  { pt: 'Artes plásticas', en: 'Eggs & Dairy' },
  { pt: 'Circo', en: 'Meat & Fish' },
  { pt: 'Comunidade', en: 'Bakery' },
  { pt: 'Humor', en: 'Pantry' },
  { pt: 'Quadrinhos', en: '' },
  { pt: 'Dança', en: '' },
  { pt: 'Design', en: 'Snacks' },
  { pt: 'Eventos', en: 'Drinks' },
  { pt: 'Moda', en: 'Bundles' },
  { pt: 'Gastronomia', en: 'CSA' },
  { pt: 'Cinema e Vídeo', en: 'Floral & Home' },
  { pt: 'Jogos', en: 'Prepared Foods' },

].each do |name|
   category = Category.find_or_initialize_by(name_pt: name[:pt])
   category.update_attributes({
     name_en: name[:en]
   })
 end

{
  company_name: 'ProduceRun',
  company_logo: 'http://catarse.me/assets/catarse_bootstrap/logo_icon_catarse.png',
  host: 'producerun.com',
  base_url: "http://www.producerun.com",

  email_contact: 'info+contact@producerun.com',
  email_payments: 'info+finance@producerun.com',
  email_projects: 'info+projects@producerun.com',
  email_system: 'info+system@producerun.com',
  email_no_reply: 'info+no-reply@producerun.com',
  facebook_url: "https://www.facebook.com/producerun",
  facebook_app_id: '173747042661491',
  twitter_url: 'http://twitter.com/producerun',
  twitter_username: "producerun",
  mailchimp_url: "http://catarse.us5.list-manage.com/subscribe/post?u=ebfcd0d16dbb0001a0bea3639&amp;id=149c39709e",
  catarse_fee: '0.13',
  support_forum: 'http://suporte.producerun.com/',
  base_domain: 'producerun.com',
  uservoice_secret_gadget: 'change_this',
  uservoice_key: 'uservoice_key',
  faq_url: 'http://suporte.producerun.com/',
  feedback_url: 'http://suporte.catarse.me/forums/103171-catarse-ideias-gerais',
  terms_url: 'http://suporte.catarse.me/knowledgebase/articles/161100-termos-de-uso',
  privacy_url: 'http://suporte.catarse.me/knowledgebase/articles/161103-pol%C3%ADtica-de-privacidade',
  about_channel_url: 'http://blog.catarse.me/conheca-os-canais-do-catarse/',
  instagram_url: 'http://instagram.com/producerun_',
  blog_url: "http://blog.producerun.com",
  github_url: 'http://github.com/producerun',
  contato_url: 'http://suporte.catarse.me/'
}.each do |name, value|
   conf = CatarseSettings.find_or_initialize_by(name: name)
   conf.update_attributes({
     value: value
   }) if conf.new_record?
end


Channel.find_or_create_by!(name: "Channel name") do |c|
  c.permalink = "sample-permalink"
  c.description = "Lorem Ipsum"
end


OauthProvider.find_or_create_by!(name: 'facebook') do |o|
#  o.key = '866987556654483'
  o.key = '39410167937'
#  o.secret = 'b68b25331704a65aced29084bab866ce'
  o.secret = 'e55126b947fccbff9a86d9716c179860'
  o.path = 'facebook'
end

puts
puts '============================================='
puts ' Showing all Authentication Providers'
puts '---------------------------------------------'

OauthProvider.all.each do |conf|
  a = conf.attributes
  puts "  name #{a['name']}"
  puts "     key: #{a['key']}"
  puts "     secret: #{a['secret']}"
  puts "     path: #{a['path']}"
  puts
end


puts
puts '============================================='
puts ' Showing all entries in Configuration Table...'
puts '---------------------------------------------'

CatarseSettings.all.each do |conf|
  a = conf.attributes
  puts "  #{a['name']}: #{a['value']}"
end

Rails.cache.clear

puts '---------------------------------------------'
puts 'Done!'
