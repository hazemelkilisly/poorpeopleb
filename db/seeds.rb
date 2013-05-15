# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

organization = Organization.create(:title=>'PPB',:description=>'NGO for Micro-loans',:phone=>'01147044492',:website=>'Not Yet',:city=>'Cairo')
admin = Admin.create(:name=>'Admin1',:organization => organization,:email=>'admin@admin.com',:password=>'123456')
borrower = Borrower.create(:name=>'7amada',:phone=>'01147044492',:city=>'Cairo',:destrict=>'Heliopolis',:job=>'5odary',:monthly_income=>5000,:creator=>admin)
cas = Case.create(:title=>'Computer Shop',:governorate=>'Cairo',:type=>'open shop',:description=>'should have done moreeee!!',:total_money=>6000,:starting_date=>DateTime.new(2013,8,14),:experienced_owner=>true,:inst_months=>13,:creator=>admin)
cas = Case.create(:title=>'M7al Khodaar',:governorate=>'Giza',:type=>'open shop',:description=>'should have done moreeee!!',:total_money=>6000,:starting_date=>DateTime.new(2013,8,14),:experienced_owner=>true,:inst_months=>13,:creator=>admin)