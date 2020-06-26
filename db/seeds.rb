# ワンピースシミュレーション
luffy = User.create!(name: "モンキー・D・ルフィ",
            email: "luffy@example.com",
            password: "password",
            confirmed_at: Time.current,
            tag_list: ["王下七武海","四皇","能力者","兄弟","家族","同盟","大将","最悪の世代"])

cate1 = luffy.categories.create!(name: "麦わらの一味")
cate2 = luffy.categories.create!(name: "海賊")
cate3 = luffy.categories.create!(name: "海軍")
cate4 = luffy.categories.create!(name: "革命軍")
cate5 = luffy.categories.create!(name: "放浪者")
cate6 = luffy.categories.create!(name: "住民")
#麦わらの一味
zoro=luffy.hyles.create!(category: cate1,name: "ロロノア・ゾロ",birthday: Date.parse("1999-11-11"),birthday_date:"1111",birthday_left:143,total_relationship: 10,tag_list:["最悪の世代"])
nami=luffy.hyles.create!(category: cate1,name: "ナミ",birthday: Date.parse("2000-7-3"),birthday_date:"0703",birthday_left:12,total_relationship: 60)
usopp=luffy.hyles.create!(category: cate1,name: "ウソップ",birthday: Date.parse("1999-4-1"),birthday_date:"0401",birthday_left:284,total_relationship: 100)
sanji=luffy.hyles.create!(category: cate1,name: "ヴィンスモーク・サンジ",birthday: Date.parse("1999-3-2"),birthday_date:"0302",birthday_left:254,total_relationship: 120)
chopper=luffy.hyles.create!(category: cate1,name: "トニートニー・チョッパー",birthday: Date.parse("2003-12-24"),birthday_date:"1224",birthday_left:186,total_relationship: 10,tag_list:["能力者"])
robin=luffy.hyles.create!(category: cate1,name: "ニコ・ロビン",birthday: Date.parse("1990-2-6"),birthday_date:"0206",birthday_left:230,total_relationship: 106,tag_list:["能力者"])
franky=luffy.hyles.create!(category: cate1,name: "フランキー",birthday: Date.parse("1984-3-9"),birthday_date:"0309",birthday_left:261,total_relationship: 17)
brook=luffy.hyles.create!(category: cate1,name: "ブルック",birthday: Date.parse("1930-4-3"),birthday_date:"0403",birthday_left:286,total_relationship: 31,tag_list:["能力者"])
#ルフィの兄弟
ace=luffy.hyles.create!(category: cate2,name: "エース",birthday: Date.parse("1998-1-1"),birthday_date:"0101",birthday_left:194,total_relationship: 5,tag_list:["能力者","兄弟"])
sabo=luffy.hyles.create!(category: cate4,name: "サボ",birthday: Date.parse("1998-3-20"),birthday_date:"0320",birthday_left:272,total_relationship: 150,tag_list:["能力者","兄弟"])
#海軍
sengoku=luffy.hyles.create!(category: cate3,name: "センゴク",birthday: nil,total_relationship: 0,tag_list:["能力者"])
garp=luffy.hyles.create!(category: cate3,name: "ガープ",birthday: Date.parse("1942-5-2"),birthday_date:"0502",birthday_left:315,total_relationship: 10,tag_list:["家族"])
akainu=luffy.hyles.create!(category: cate3,name: "赤犬",birthday: Date.parse("1965-8-16"),birthday_date:"0816",birthday_left:56,total_relationship: 40,tag_list:["能力者","大将"])
kizaru=luffy.hyles.create!(category: cate3,name: "黄猿",birthday: Date.parse("1962-11-23"),birthday_date:"1123",birthday_left:155,total_relationship: 60,tag_list:["能力者","大将"])
fujitora=luffy.hyles.create!(category: cate3,name: "藤虎",birthday: Date.parse("1966-8-10"),birthday_date:"0810",birthday_left:50,total_relationship: 80,tag_list:["能力者","大将"])
cobby=luffy.hyles.create!(category: cate3,name: "コビー",birthday: Date.parse("2002-5-13"),birthday_date:"0513",birthday_left:326,total_relationship: 0)
#青キジ
aokiji=luffy.hyles.create!(category: cate5,name: "青雉",birthday: Date.parse("1973-9-21"),birthday_date:"0921",birthday_left:92,total_relationship: 30,tag_list:["能力者"])
#バギー海賊団
baggy=luffy.hyles.create!(category: cate2,name: "バギー",birthday: Date.parse("1981-8-8"),birthday_date:"0808",birthday_left:48,total_relationship: 90,tag_list:["王下七武海","能力者"])
albida=luffy.hyles.create!(category: cate2,name: "アルビダ",birthday: Date.parse("1993-3-14"),birthday_date:"0314",birthday_left:266,total_relationship: 0,tag_list:["能力者"])
mr3=luffy.hyles.create!(category: cate2,name: "Mr.3",birthday: nil,total_relationship: 0,tag_list:["能力者"])
#空島
enel=luffy.hyles.create!(category: cate5,name: "エネル",birthday: nil,total_relationship: 0,tag_list:["能力者"])
#４皇
kaido=luffy.hyles.create!(category: cate2,name: "カイドウ",birthday: nil,total_relationship: 0,tag_list:["四皇","能力者"])
shanks=luffy.hyles.create!(category: cate2,name: "シャンクス",birthday: Date.parse("1983-3-9"),birthday_date:"0309",birthday_left:261,total_relationship: 0,tag_list:["四皇"])
teech=luffy.hyles.create!(category: cate2,name: "マーシャル・D・ティーチ",birthday: Date.parse("1982-8-3"),birthday_date:"0803",birthday_left:43,total_relationship: 70,tag_list:["四皇","能力者"])
#和の国
kin=luffy.hyles.create!(category: cate5,name: "錦えもん",birthday: nil,total_relationship: 0,tag_list:["能力者"])
#人魚
kaimy=luffy.hyles.create!(category: cate6,name: "ケイミー",birthday: Date.parse("2002-11-3"),birthday_date:"1103",birthday_left:135,total_relationship: 0)
#海賊
roe=luffy.hyles.create!(category: cate2,name: "トラファルガー・ロー",birthday: Date.parse("1994-10-6"),birthday_date:"1006",birthday_left:107,total_relationship: 70,tag_list:["王下七武海","能力者","同盟","最悪の世代"])
hancok=luffy.hyles.create!(category: cate2,name: "ボア・ハンコック",birthday: nil,total_relationship: 10,tag_list:["王下七武海","能力者"])
kit=luffy.hyles.create!(category: cate2,name: "ユースタス・キッド",birthday: Date.parse("1997-1-10"),birthday_date:"0110",birthday_left:203,total_relationship: 0,tag_list:["能力者","最悪の世代"])
#ビビ
bibi=luffy.hyles.create!(category: cate6,name: "ビビ",birthday: Date.parse("2002-2-2"),birthday_date:"0202",birthday_left:226,total_relationship: 0)
#ドラゴン
dragon=luffy.hyles.create!(category: cate4,name: "ドラゴン",birthday: nil,total_relationship: 0,tag_list:["能力者","家族"])
#思い出
memory1 = luffy.memories.create!(title:"頂上戦争",date:Date.parse("2018-12-1"),description:"エースの公開処刑を止めるための、白髭海賊団VS海軍!\nエースの救出には成功したものの、その後赤犬からルフィを庇ってエースは死去。黒ひげの乱入により白ひげも後を追い、場が混乱していたところをシャンクスが来て、戦争を終わらせた。")
memory1.hyle_memories.create!(hyle:ace)
memory1.hyle_memories.create!(hyle:sengoku)
memory1.hyle_memories.create!(hyle:garp)
memory1.hyle_memories.create!(hyle:akainu)
memory1.hyle_memories.create!(hyle:kizaru)
memory1.hyle_memories.create!(hyle:aokiji)
memory1.hyle_memories.create!(hyle:shanks)
memory1.hyle_memories.create!(hyle:teech)
memory1.hyle_memories.create!(hyle:cobby)
memory1.hyle_memories.create!(hyle:roe)
memory1.hyle_memories.create!(hyle:hancok)
memory2 = luffy.memories.create!(title:"麦わらの一味再集結",date:Date.parse("2020-1-1"),description:"一味それぞれが２年間の修行を経て、シャボンディ諸島に再び集結!\n麦わらの一味を偽る海賊がいたり、海軍がその海賊を捕らえるために上陸していたりで混乱していたが、たくさんの味方のサポートもあり無事に魚人島への出向に成功！")
memory2.hyle_memories.create!(hyle:zoro)
memory2.hyle_memories.create!(hyle:nami)
memory2.hyle_memories.create!(hyle:sanji)
memory2.hyle_memories.create!(hyle:usopp)
memory2.hyle_memories.create!(hyle:chopper)
memory2.hyle_memories.create!(hyle:robin)
memory2.hyle_memories.create!(hyle:franky)
memory2.hyle_memories.create!(hyle:brook)
memory3 = luffy.memories.create!(title:"和の国",date:Date.parse("2020-5-1"),description:"いよいよカイドウを倒すべく、和の国へ上陸！\nカイドウの統べる和の国は、汚染された環境で食糧の普及すらままなっていなかった。そんな中、錦えもんたちの正体も発覚。これから作戦を実行するが、果たしてどうなるのか。。")
memory3.hyle_memories.create!(hyle:zoro)
memory3.hyle_memories.create!(hyle:nami)
memory3.hyle_memories.create!(hyle:sanji)
memory3.hyle_memories.create!(hyle:usopp)
memory3.hyle_memories.create!(hyle:chopper)
memory3.hyle_memories.create!(hyle:robin)
memory3.hyle_memories.create!(hyle:franky)
memory3.hyle_memories.create!(hyle:brook)
memory3.hyle_memories.create!(hyle:kin)
memory3.hyle_memories.create!(hyle:roe)
memory3.hyle_memories.create!(hyle:kaido)
memory4 = luffy.memories.create!(title:"アラバスタ",date:Date.parse("2018-3-1"),description:"クロコダイルがアラバスタの国民を騙して内争を起こしていた。ビビと共に戦争を止めるため、クロコダイルを倒すため、アラバスタに上陸！")
memory4.hyle_memories.create!(hyle:zoro)
memory4.hyle_memories.create!(hyle:nami)
memory4.hyle_memories.create!(hyle:sanji)
memory4.hyle_memories.create!(hyle:usopp)
memory4.hyle_memories.create!(hyle:chopper)
memory4.hyle_memories.create!(hyle:robin)
memory4.hyle_memories.create!(hyle:bibi)
memory4 = luffy.memories.create!(title:"空島",date:Date.parse("2018-7-1"),description:"へそ！まさかの空に縞があった！モンブランの伝説、黄金の伝説、数々の謎が秘める中、神を名乗るエネルが何やらゲームを始める")
memory4.hyle_memories.create!(hyle:zoro)
memory4.hyle_memories.create!(hyle:nami)
memory4.hyle_memories.create!(hyle:sanji)
memory4.hyle_memories.create!(hyle:usopp)
memory4.hyle_memories.create!(hyle:chopper)
memory4.hyle_memories.create!(hyle:robin)
memory4.hyle_memories.create!(hyle:enel)






# デモユーザー
user = User.create!(name: "田中太郎",
            email: "taro@example.com",
            password: "password",
            confirmed_at: Time.current,
            tag_list: ["中学の頃","高校の頃","大学の頃","飲み仲間","愛人","幼なじみ","野球部"])

categ1 = user.categories.create!(name: "家族")
categ2 = user.categories.create!(name: "イツメン")
categ3 = user.categories.create!(name: "友達")
categ4 = user.categories.create!(name: "〇〇会社")
categ5 = user.categories.create!(name: "SNS友達")
categ6 = user.categories.create!(name: "先生")
#家族
father=user.hyles.create!(category: categ1,name: "田中仁",birthday: Date.parse("1970-11-11"),birthday_date:"1111")
mother=user.hyles.create!(category: categ1,name: "田中まゆみ",birthday: Date.parse("1970-7-3"),birthday_date:"0703")
bro=user.hyles.create!(category: categ1,name: "田中次郎",birthday: Date.parse("1999-4-1"),birthday_date:"0401")
sis=user.hyles.create!(category: categ1,name: "田中あやか",birthday: Date.parse("2001-3-2"),birthday_date:"0302")
granpa=user.hyles.create!(category: categ1,name: "田中誠司",birthday: Date.parse("1930-12-24"),birthday_date:"1224")
granma=user.hyles.create!(category: categ1,name: "田中昌子",birthday: Date.parse("1930-2-6"),birthday_date:"0206")
pet=user.hyles.create!(category: categ1,name: "ポチ",birthday: Date.parse("2005-3-9"),birthday_date:"0309")
#イツメン
koji=user.hyles.create!(category: categ2,name: "森山浩二",birthday: Date.parse("1996-1-1"),birthday_date:"0101",tag_list:["中学の頃","野球部"])
haru=user.hyles.create!(category: categ2,name: "佐竹晴",birthday: Date.parse("1996-3-20"),birthday_date:"0320",tag_list:["幼なじみ","野球部","飲み仲間"])
#友達
hiroko=user.hyles.create!(category: categ3,name: "北浩子",birthday: Date.parse("1996-7-8"),birthday_date:"0708",tag_list:["大学の頃","愛人"])
kenta=user.hyles.create!(category: categ3,name: "松谷健太",birthday: Date.parse("1996-5-2"),birthday_date:"0502",tag_list:["飲み仲間","野球部","高校の頃"])
yuji=user.hyles.create!(category: categ3,name: "芝ゆうじ",birthday: Date.parse("1996-8-16"),birthday_date:"0816",tag_list:["中学の頃","兄弟"])
mirai=user.hyles.create!(category: categ3,name: "百瀬未来",birthday: Date.parse("1996-11-23"),birthday_date:"1123",tag_list:["幼なじみ","兄弟","飲み仲間"])
yuta=user.hyles.create!(category: categ3,name: "北見雄太",birthday: Date.parse("1996-8-10"),birthday_date:"0810",tag_list:["高校の頃","兄弟"])
chika=user.hyles.create!(category: categ3,name: "大島千佳",birthday: Date.parse("1996-5-13"),birthday_date:"0513",tag_list:["高校の頃","野球部"])
#〇〇会社
kazuki=user.hyles.create!(category: categ4,name: "広島かずき",birthday: Date.parse("1989-9-21"),birthday_date:"0921")
hayato=user.hyles.create!(category: categ4,name: "松前隼人",birthday: Date.parse("1992-12-21"),birthday_date:"1221",tag_list:["飲み仲間"])
riku=user.hyles.create!(category: categ4,name: "南口淕",birthday: Date.parse("1993-7-21"),birthday_date:"0721",tag_list:["飲み仲間"])
atsushi=user.hyles.create!(category: categ4,name: "世古敦",birthday: Date.parse("1993-1-21"),birthday_date:"0121",tag_list:["大学の頃"])
taishi=user.hyles.create!(category: categ4,name: "上田太一",birthday: Date.parse("1993-12-1"),birthday_date:"1201")
#SNS友達
macky=user.hyles.create!(category: categ5,name: "マッキー宏",birthday: Date.parse("1991-8-8"),birthday_date:"0808")
ayaaya=user.hyles.create!(category: categ5,name: "あやあや",birthday: nil)
miminaga=user.hyles.create!(category: categ5,name: "耳なが族",birthday: nil)
#先生
kazuhiko=user.hyles.create!(category: categ6,name: "中島和彦",birthday: nil,tag_list:["中学の頃"])
saki=user.hyles.create!(category: categ6,name: "三宅咲",birthday: nil,tag_list:["中学の頃"])
teruo=user.hyles.create!(category: categ6,name: "大山輝雄",birthday: nil,tag_list:["高校の頃"])
masao=user.hyles.create!(category: categ6,name: "山下正雄",birthday: nil,tag_list:["大学の頃"])
#ラベル
user.labels.create!(hyle:koji,name:"趣味",body:"麻雀")
user.labels.create!(hyle:haru,name:"嫌いな食べ物",body:"トマト")
user.labels.create!(hyle:hiroko,name:"アレルギー",body:"卵")
user.labels.create!(hyle:kenta,name:"備考",body:"まだ2000円返してもらってない")
user.labels.create!(hyle:yuta,name:"趣味",body:"漫画")
#思い出
memory1 = user.memories.create!(title:"2019年忘年会",date:Date.parse("2019-12-14"),description:"イツメンで日本食料理店「里」で忘年会！")
memory1.hyle_memories.create!(hyle:koji)
memory1.hyle_memories.create!(hyle:haru)
memory2 = user.memories.create!(title:"皿を割り先生に叱られる",date:Date.parse("2010-5-1"),description:"給食の時間、皿を割って怒られた")
memory2.hyle_memories.create!(hyle:saki)
memory2.hyle_memories.create!(hyle:koji)
memory2.hyle_memories.create!(hyle:yuji)
memory3 = user.memories.create!(title:"修学旅行",date:Date.parse("2014-5-1"),description:"高校の修学旅行！最高に楽しかった！")
memory3.hyle_memories.create!(hyle:teruo)
memory3.hyle_memories.create!(hyle:yuta)
memory3.hyle_memories.create!(hyle:chika)
memory3.hyle_memories.create!(hyle:haru)
memory4 = user.memories.create!(title:"告白成功！",date:Date.parse("2018-3-1"),description:"ひろちゃんに告白！成功！！")
memory4.hyle_memories.create!(hyle:hiroko)
memory4 = user.memories.create!(title:"銀婚式",date:Date.parse("2016-7-1"),description:"おじいちゃんおばあちゃんの銀婚式！いろんな親戚に会った。")
memory4.hyle_memories.create!(hyle:father)
memory4.hyle_memories.create!(hyle:mother)
memory4.hyle_memories.create!(hyle:bro)
memory4.hyle_memories.create!(hyle:sis)
memory4.hyle_memories.create!(hyle:granpa)
memory4.hyle_memories.create!(hyle:granma)
#関係
rel1=user.daily_relationships.create!(created_at:1.day.ago)
rel1.hyle_daily_relationships.create!(hyle:father,relationship_amount:40)
rel1.hyle_daily_relationships.create!(hyle:mother,relationship_amount:30)
rel1.hyle_daily_relationships.create!(hyle:bro,relationship_amount:70)
rel1.hyle_daily_relationships.create!(hyle:koji,relationship_amount:80)
rel2=user.daily_relationships.create!(created_at:2.day.ago)
rel2.hyle_daily_relationships.create!(hyle:father,relationship_amount:40)
rel2.hyle_daily_relationships.create!(hyle:mother,relationship_amount:50)
rel2.hyle_daily_relationships.create!(hyle:haru,relationship_amount:90)
rel3=user.daily_relationships.create!(created_at:3.day.ago)
rel3.hyle_daily_relationships.create!(hyle:hayato,relationship_amount:90)
rel3.hyle_daily_relationships.create!(hyle:father,relationship_amount:20)
rel3.hyle_daily_relationships.create!(hyle:kenta,relationship_amount:40)
