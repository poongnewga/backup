# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# admin:
User.create(nickname: "admin", password: "1234", age: "26", gender: "m", email: "asdf@asdf.com",
            company: "멋사", location: {latitude: 37.497200, longitude: 127.026264}.to_json,
            lunchtime: "{\"start\":\"15:00 PM\",\"finish\":\"18:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true, admin: true)

# male
User.create(nickname: "네이버", password: "1234", age: "25", gender: "m", email: "asdf@asdf.com",
            company: "네이버", location: {latitude: 37.497200, longitude: 127.026264}.to_json,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)


User.create(nickname: "male_2", password: "1234", age: "25", gender: "m", email: "asdf@asdf.com",
            company: "네이버", location: {latitude: 37.497200, longitude: 127.026264}.to_json,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)



User.create(nickname: "male_3", password: "1234", age: "26", gender: "m", email: "asdf@asdf.com",
            company: "엘지화학", location: {latitude: 37.498427, longitude: 127.026870}.to_json,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:30 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)

User.create(nickname: "male_4", password: "1234", age: "26", gender: "m", email: "asdf@asdf.com",
            company: "엘지화학", location: {latitude: 37.498427, longitude: 127.026870}.to_json,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:30 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)

User.create(nickname: "male_5", password: "1234", age: "26", gender: "m", email: "asdf@asdf.com",
            company: "DK음악학원", location: {latitude: 37.498203, longitude: 127.030051}.to_json,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)



User.create(nickname: "male_6", password: "1234", age: "25", gender: "m", email: "asdf@asdf.com",
            company: "네이버", location: {latitude: 37.497200, longitude: 127.026264}.to_json,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)


# female
User.create(nickname: "마이크로소프트", password: "1234", age: "23", gender: "f", email: "asdf@asdf.com",
            company: "마이크로소프트", location: {latitude: 37.498615, longitude: 127.028705}.to_json,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)

User.create(nickname: "female_2", password: "1234", age: "24", gender: "f", email: "asdf@asdf.com",
            company: "마이크로소프트", location: {latitude: 37.498615, longitude: 127.028705}.to_json,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)

User.create(nickname: "female_3", password: "1234", age: "25", gender: "f", email: "asdf@asdf.com",
            company: "메리츠화재", location: {latitude: 37.497139, longitude: 127.028553}.to_json,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:30 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)

User.create(nickname: "female_4", password: "1234", age: "25", gender: "f", email: "asdf@asdf.com",
            company: "메리츠화재", location: {latitude: 37.497139, longitude: 127.028553}.to_json,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:30 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)

User.create(nickname: "female_5", password: "1234", age: "26", gender: "f", email: "asdf@asdf.com",
            company: "삼성전자", location: {latitude: 37.498552, longitude: 127.030845}.to_json,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)



User.create(nickname: "female_6", password: "1234", age: "26", gender: "f", email: "asdf@asdf.com",
            company: "우리은행", location: {latitude: 37.495650, longitude: 127.028146}.to_json,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)



User.create(nickname: "female_7", password: "1234", age: "26", gender: "f", email: "asdf@asdf.com",
            company: "CJ제일제당", location: {latitude: 37.498148, longitude: 127.030714}.to_json,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)

User.create(nickname: "female_8", password: "1234", age: "26", gender: "f", email: "asdf@asdf.com",
            company: "CJ제일제당", location: {latitude: 37.498148, longitude: 127.030714}.to_json,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)

User.create(nickname: "female_9", password: "1234", age: "26", gender: "f", email: "asdf@asdf.com",
            company: "CJ제일제당", location: {latitude: 37.498148, longitude: 127.030714}.to_json,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", photo: nil, card: nil,
            token: "hi", notice: true, push: true, push_token: "hi", email_confirmed: true)




# group
@mg1 = Group.create(gender: "m", people: 2, location: {latitude: 37.497200, longitude: 127.026264}.to_json,
            day: "{\"mon\":\"1\",\"tue\":\"0\",\"wed\":\"0\",\"thu\":\"0\",\"fri\":\"0\"}", week: 20170807,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", matched: false, company: "네이버")
User.find_by(nickname: "네이버").groups << @mg1
User.find_by(nickname: "male_2").groups << @mg1


@mg2 = Group.create(gender: "m", people: 2, location: {latitude: 37.498427, longitude: 127.026870}.to_json,
            day: "{\"mon\":\"0\",\"tue\":\"1\",\"wed\":\"1\",\"thu\":\"1\",\"fri\":\"0\"}", week: 20170807,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:30 PM\"}", matched: false, company: "엘지화학")
User.find_by(nickname: "male_3").groups << @mg2
User.find_by(nickname: "male_4").groups << @mg2

@fg1 = Group.create(gender: "f", people: 2, location: {latitude: 37.498615, longitude: 127.028705}.to_json,
            day: "{\"mon\":\"1\",\"tue\":\"1\",\"wed\":\"0\",\"thu\":\"1\",\"fri\":\"0\"}", week: 20170807,
            lunchtime:"{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", matched: false, company: "마이크로소프트")
User.find_by(nickname: "마이크로소프트").groups << @fg1
User.find_by(nickname: "female_2").groups << @fg1

@fg2 = Group.create(gender: "f", people: 2, location: {latitude: 37.497139, longitude: 127.028553}.to_json,
            day: "{\"mon\":\"0\",\"tue\":\"1\",\"wed\":\"1\",\"thu\":\"0\",\"fri\":\"0\"}", week: 20170807,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:30 PM\"}", matched: false, company: "메리츠화재")
User.find_by(nickname: "female_3").groups << @fg2
User.find_by(nickname: "female_4").groups << @fg2

@mg_1 = Group.create(gender: "m", people: 1, location: {latitude: 37.498203, longitude: 127.030051}.to_json,
            day: "{\"mon\":\"1\",\"tue\":\"0\",\"wed\":\"1\",\"thu\":\"0\",\"fri\":\"0\"}", week: 20170807,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", matched: false, company: "DK음악학원")
User.find_by(nickname: "male_5").groups << @mg_1

@fg_1 = Group.create(gender: "f", people: 1, location: {latitude: 37.498552, longitude: 127.030845}.to_json,
            day: "{\"mon\":\"1\",\"tue\":\"0\",\"wed\":\"0\",\"thu\":\"1\",\"fri\":\"0\"}", week: 20170807,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", matched: false, company: "삼성전자")
User.find_by(nickname: "female_5").groups << @fg_1



@mg_2 = Group.create(gender: "m", people: 1, location: {latitude: 37.497200, longitude: 127.026264}.to_json,
            day: "{\"mon\":\"0\",\"tue\":\"1\",\"wed\":\"0\",\"thu\":\"1\",\"fri\":\"0\"}", week: 20170807,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", matched: false, company: "네이버")
User.find_by(nickname: "네이버").groups << @mg_2

@fg_2 = Group.create(gender: "f", people: 1, location: {latitude: 37.495650, longitude: 127.028146}.to_json,
            day: "{\"mon\":\"1\",\"tue\":\"0\",\"wed\":\"0\",\"thu\":\"1\",\"fri\":\"0\"}", week: 20170807,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", matched: false, company: "우리은행")
User.find_by(nickname: "female_6").groups << @fg_2


#0804추가
@mg_3 = Group.create(gender: "m", people: 1, location: {latitude: 37.497200, longitude: 127.026264}.to_json,
            day: "{\"mon\":\"0\",\"tue\":\"0\",\"wed\":\"1\",\"thu\":\"0\",\"fri\":\"1\"}", week: 20170807,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", matched: false, company: "네이버")
User.find_by(nickname: "네이버").groups << @mg_3

@fg_3 = Group.create(gender: "f", people: 1, location: {latitude: 37.498615, longitude: 127.028705}.to_json,
            day: "{\"mon\":\"1\",\"tue\":\"0\",\"wed\":\"0\",\"thu\":\"1\",\"fri\":\"0\"}", week: 20170807,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", matched: false, company: "마이크로소프트")
User.find_by(nickname: "마이크로소프트").groups << @fg_3


@mg_4 = Group.create(gender: "m", people: 1, location: {latitude: 37.497200, longitude: 127.026264}.to_json,
            day: "{\"mon\":\"0\",\"tue\":\"0\",\"wed\":\"1\",\"thu\":\"0\",\"fri\":\"1\"}", week: 20170807,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", matched: false, company: "네이버")
User.find_by(nickname: "male_2").groups << @mg_4

@fg_4 = Group.create(gender: "f", people: 1, location: {latitude: 37.498615, longitude: 127.028705}.to_json,
            day: "{\"mon\":\"1\",\"tue\":\"0\",\"wed\":\"0\",\"thu\":\"1\",\"fri\":\"0\"}", week: 20170807,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", matched: false, company: "마이크로소프트")
User.find_by(nickname: "마이크로소프트").groups << @fg_4

@mg_5 = Group.create(gender: "m", people: 1, location: {latitude: 37.497200, longitude: 127.026264}.to_json,
            day: "{\"mon\":\"0\",\"tue\":\"0\",\"wed\":\"0\",\"thu\":\"0\",\"fri\":\"1\"}", week: 20170807,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", matched: true, company: "네이버")
User.find_by(nickname: "네이버").groups << @mg_5

@fg_5 = Group.create(gender: "f", people: 1, location: {latitude: 37.498552, longitude: 127.030845}.to_json,
            day: "{\"mon\":\"1\",\"tue\":\"1\",\"wed\":\"1\",\"thu\":\"1\",\"fri\":\"0\"}", week: 20170807,
            lunchtime: "{\"start\":\"11:30 AM\",\"finish\":\"13:00 PM\"}", matched: false, company: "삼성전자")
User.find_by(nickname: "female_5").groups << @fg_5


@mg3_3 = Group.create(gender: "m", people: 3, location: {latitude: 37.497200, longitude: 127.026264}.to_json,
            day: "{\"mon\":\"1\",\"tue\":\"0\",\"wed\":\"0\",\"thu\":\"0\",\"fri\":\"1\"}", week: 20170807,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", matched: true, company: "네이버")
User.find_by(nickname: "네이버").groups << @mg3_3
User.find_by(nickname: "male_2").groups << @mg3_3
User.find_by(nickname: "male_3").groups << @mg3_3



@fg3_3 = Group.create(gender: "f", people: 3, location: {latitude: 37.498148, longitude: 127.030714}.to_json,
            day: "{\"mon\":\"1\",\"tue\":\"1\",\"wed\":\"0\",\"thu\":\"1\",\"fri\":\"1\"}", week: 20170807,
            lunchtime: "{\"start\":\"12:00 PM\",\"finish\":\"13:00 PM\"}", matched: true, company: "CJ제일제당")
User.find_by(nickname: "female_7").groups << @fg3_3
User.find_by(nickname: "female_8").groups << @fg3_3
User.find_by(nickname: "female_9").groups << @fg3_3











#미팅
@m1 = Meeting.create(date: 20170817, day: "목", lunchtime: "{\"start\":\"12:00\",\"finish\":\"13:00\"}", center: {latitude: 37.49852100354786, longitude: 127.02778749884503}.to_json,
                pin_m: {latitude: 37.498427, longitude: 127.02687}.to_json, pin_f: {latitude: 37.498615, longitude: 127.028705}.to_json, p_count: "4",
                company: "{\"male\":\"엘지화학\",\"female\":\"마이크로소프트\"}")

@mg2.meetings << @m1
@fg1.meetings << @m1

@m2 = Meeting.create(date: 20170815, day: "화", lunchtime: "{\"start\":\"12:00\",\"finish\":\"13:00\"}", center: {latitude: 37.49754795419014, longitude: 127.0275}.to_json,
                pin_m: {latitude: 37.497200, longitude: 127.026264}.to_json, pin_f: {latitude: 37.497139, longitude: 127.028553}.to_json, p_count: "4",
                company: "{\"male\":\"네이버\",\"female\":\"메리츠화재\"}")
@mg1.meetings << @m2
@fg2.meetings << @m2

@m3 = Meeting.create(date: 20170814, day: "월", lunchtime: "{\"start\":\"11:30\",\"finish\":\"13:00\"}", center: {latitude: 37.49837750066425, longitude: 127.0304}.to_json,
                pin_m: {latitude: 37.498203, longitude: 127.030051}.to_json, pin_f: {latitude: 37.498552, longitude: 127.030845}.to_json,
                company: "{\"male\":\"DK음악학원\",\"female\":\"삼성전자\"}")

@mg_1.meetings << @m3
@fg_1.meetings << @m3

@m4 = Meeting.create(date: 20170808, day: "화", lunchtime: "{\"start\":\"12:00\",\"finish\":\"13:00\"}",
                center: {latitude: 37.496803452654305, longitude: 127.02735241225767}.to_json,
                pin_m: "{\"latitude\":37.4973245,\"longitude\":127.0265588}",
                pin_f: {latitude: 37.495650, longitude: 127.028146}.to_json,
                p_count: "2", company: "{\"male\":\"네이버\",\"female\":\"우리은행\"}")

@mg_2.meetings << @m4
@fg_2.meetings << @m4

@m5 = Meeting.create(date: 20170816, day: "수", lunchtime: "{\"start\":\"12:00\",\"finish\":\"13:00\"}",
                center: {latitude: 37.49828595485327, longitude: 127.0276318952714}.to_json,
                pin_m: "{\"latitude\":37.4973245,\"longitude\":127.0265588}",
                pin_f: {latitude: 37.498615, longitude: 127.028705}.to_json,
                p_count: "2", company: "{\"male\":\"네이버\",\"female\":\"마이크로소프트\"}")

@mg_3.meetings << @m5
@fg_3.meetings << @m5

@m6 = Meeting.create(date: 20170814, day: "월", lunchtime: "{\"start\":\"12:00\",\"finish\":\"13:00\"}",
                center: {latitude: 37.497969754853266, longitude: 127.02763189072755}.to_json,
                pin_m: "{\"latitude\":37.4973245,\"longitude\":127.0265588}",
                pin_f: {latitude: 37.498615, longitude: 127.028705}.to_json,
                p_count: "2", company: "{\"male\":\"네이버\",\"female\":\"마이크로소프트\"}")

@mg_4.meetings << @m6
@fg_4.meetings << @m6

@m6 = Meeting.create(date: 20170728, day: "금", lunchtime: "{\"start\":\"12:00\",\"finish\":\"13:30\"}",
                center: {latitude: 37.497938269356986, longitude: 127.02870188238593}.to_json,
                pin_m: "{\"latitude\":37.4973245,\"longitude\":127.0265588}",
                pin_f: {latitude: 37.498552, longitude: 127.030845}.to_json,
                p_count: "2", company: "{\"male\":\"네이버\",\"female\":\"삼성전자\"}")

@mg_5.meetings << @m6
@fg_5.meetings << @m6


@m7 = Meeting.create(date: 20170810, day: "목", lunchtime: "{\"start\":\"12:00\",\"finish\":\"13:30\"}",
                center: {latitude: 37.49773626819181, longitude: 127.02863638854441}.to_json,
                pin_m: "{\"latitude\":37.4973245,\"longitude\":127.0265588}",
                pin_f: {latitude: 37.498148, longitude: 127.030714}.to_json,
                p_count: "6", company: "{\"male\":\"네이버\",\"female\":\"CJ제일제당\"}")

@mg3_3.meetings << @m7
@fg3_3.meetings << @m7
