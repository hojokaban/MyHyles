User.create!(name: "sample",
            email: "sample@example.com",
            password: "password",
            confirmed_at: Time.current)
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
