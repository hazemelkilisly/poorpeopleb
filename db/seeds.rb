# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

organization = Organization.create(:title=>'PPB',:description=>'NGO for Micro-loans',:phone=>'01147044492',:website=>'Not Yet',:city=>'Cairo')
admin = Admin.create(:name=>'Admin1',:organization => organization,:email=>'admin@admin.com',:password=>'123456')

