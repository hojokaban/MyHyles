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
zoro=luffy.hyles.create!(category: cate1,name: "ロロノア・ゾロ",birthday: Date.new(1999-11-11),total_relationship: 100,tag_list:["最悪の世代"])
nami=luffy.hyles.create!(category: cate1,name: "ナミ",birthday: Date.new(2000-7-3),total_relationship: 100)
usopp=luffy.hyles.create!(category: cate1,name: "ウソップ",birthday: Date.new(1999-4-1),total_relationship: 100)
sanji=luffy.hyles.create!(category: cate1,name: "ヴィンスモーク・サンジ",birthday: Date.new(1999-3-2),total_relationship: 100)
chopper=luffy.hyles.create!(category: cate1,name: "トニートニー・チョッパー",birthday: Date.new(2003-12-24),total_relationship: 100,tag_list:["能力者"])
robin=luffy.hyles.create!(category: cate1,name: "ニコ・ロビン",birthday: Date.new(1990-2-6),total_relationship: 100,tag_list:["能力者"])
franky=luffy.hyles.create!(category: cate1,name: "フランキー",birthday: Date.new(1984-3-9),total_relationship: 100)
brook=luffy.hyles.create!(category: cate1,name: "ブルック",birthday: Date.new(1930-4-3),total_relationship: 100,tag_list:["能力者"])
#ルフィの兄弟
ace=luffy.hyles.create!(category: cate2,name: "エース",birthday: Date.new(1998-1-1),total_relationship: 50,tag_list:["能力者","兄弟"])
sabo=luffy.hyles.create!(category: cate4,name: "サボ",birthday: Date.new(1998-3-20),total_relationship: 50,tag_list:["能力者","兄弟"])
#海軍
sengoku=luffy.hyles.create!(category: cate3,name: "センゴク",birthday: nil,total_relationship: 0,tag_list:["能力者"])
garp=luffy.hyles.create!(category: cate3,name: "ガープ",birthday: Date.new(1942-5-2),total_relationship: 0,tag_list:["家族"])
akainu=luffy.hyles.create!(category: cate3,name: "赤犬",birthday: Date.new(1965-8-16),total_relationship: 0,tag_list:["能力者","大将"])
kizaru=luffy.hyles.create!(category: cate3,name: "黄猿",birthday: Date.new(1962-11-23),total_relationship: 0,tag_list:["能力者","大将"])
fujitora=luffy.hyles.create!(category: cate3,name: "藤虎",birthday: Date.new(1966-8-10),total_relationship: 0,tag_list:["能力者","大将"])
#青キジ
aokiji=luffy.hyles.create!(category: cate5,name: "青雉",birthday: Date.new(1973-9-21),total_relationship: 0,tag_list:["能力者"])
#バギー海賊団
baggy=luffy.hyles.create!(category: cate2,name: "バギー",birthday: Date.new(1981-8-8),total_relationship: 0,tag_list:["王下七武海","能力者"])
albida=luffy.hyles.create!(category: cate2,name: "アルビダ",birthday: Date.new(1993-3-14),total_relationship: 0,tag_list:["能力者"])
mr3=luffy.hyles.create!(category: cate2,name: "Mr.3",birthday: nil,total_relationship: 0,tag_list:["能力者"])
#空島
enel=luffy.hyles.create!(category: cate5,name: "エネル",birthday: nil,total_relationship: 0,tag_list:["能力者"])
#４皇
kaido=luffy.hyles.create!(category: cate2,name: "カイドウ",birthday: nil,total_relationship: 0,tag_list:["四皇","能力者"])
shanks=luffy.hyles.create!(category: cate2,name: "シャンクス",birthday: Date.new(1983-3-9),total_relationship: 0,tag_list:["四皇"])
teech=luffy.hyles.create!(category: cate2,name: "マーシャル・D・ティーチ",birthday: Date.new(1982-8-3),total_relationship: 70,tag_list:["四皇","能力者"])
#和の国
kin=luffy.hyles.create!(category: cate5,name: "錦えもん",birthday: nil,total_relationship: 0,tag_list:["能力者"])
#人魚
kaimy=luffy.hyles.create!(category: cate6,name: "ケイミー",birthday: Date.new(2002-11-3),total_relationship: 0)
cobby=luffy.hyles.create!(category: cate3,name: "コビー",birthday: Date.new(2002-5-13),total_relationship: 0)
#海賊
roe=luffy.hyles.create!(category: cate2,name: "トラファルガー・ロー",birthday: Date.new(1994-10-6),total_relationship: 70,tag_list:["王下七武海","能力者","同盟","最悪の世代"])
hancok=luffy.hyles.create!(category: cate2,name: "ボア・ハンコック",birthday: nil,total_relationship: 10,tag_list:["王下七武海","能力者"])
kit=luffy.hyles.create!(category: cate2,name: "ユースタス・キッド",birthday: Date.new(1997-1-10),total_relationship: 0,tag_list:["能力者","最悪の世代"])
#ビビ
bibi=luffy.hyles.create!(category: cate6,name: "ビビ",birthday: Date.new(2002-2-2),total_relationship: 0)
#ドラゴン
dragon=luffy.hyles.create!(category: cate4,name: "ドラゴン",birthday: Date.new(2002-2-2),total_relationship: 0,tag_list:["能力者","家族"])
#思い出
memory1 = luffy.memories.create!(title:"頂上戦争",date:Date.new(2018-12-1),description:"エースの公開処刑を止めるための、白髭海賊団VS海軍!\nエースの救出には成功したものの、その後赤犬からルフィを庇ってエースは死去。黒ひげの乱入により白ひげも後を追い、場が混乱していたところをシャンクスが来て、戦争を終わらせた。")
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
memory2 = luffy.memories.create!(title:"麦わらの一味再集結",date:Date.new(2020-1-1),description:"一味それぞれが２年間の修行を経て、シャボンディ諸島に再び集結!\n麦わらの一味を偽る海賊がいたり、海軍がその海賊を捕らえるために上陸していたりで混乱していたが、たくさんの味方のサポートもあり無事に魚人島への出向に成功！")
memory2.hyle_memories.create!(hyle:zoro)
memory2.hyle_memories.create!(hyle:nami)
memory2.hyle_memories.create!(hyle:sanji)
memory2.hyle_memories.create!(hyle:usopp)
memory2.hyle_memories.create!(hyle:chopper)
memory2.hyle_memories.create!(hyle:robin)
memory2.hyle_memories.create!(hyle:franky)
memory2.hyle_memories.create!(hyle:brook)
memory3 = luffy.memories.create!(title:"和の国",date:Date.new(2020-5-1),description:"いよいよカイドウを倒すべく、和の国へ上陸！\nカイドウの統べる和の国は、汚染された環境で食糧の普及すらままなっていなかった。そんな中、錦えもんたちの正体も発覚。これから作戦を実行するが、果たしてどうなるのか。。")
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
memory4 = luffy.memories.create!(title:"アラバスタ",date:Date.new(2018-3-1),description:"クロコダイルがアラバスタの国民を騙して内争を起こしていた。ビビと共に戦争を止めるため、クロコダイルを倒すため、アラバスタに上陸！")
memory4.hyle_memories.create!(hyle:zoro)
memory4.hyle_memories.create!(hyle:nami)
memory4.hyle_memories.create!(hyle:sanji)
memory4.hyle_memories.create!(hyle:usopp)
memory4.hyle_memories.create!(hyle:chopper)
memory4.hyle_memories.create!(hyle:robin)
memory4.hyle_memories.create!(hyle:bibi)
memory4 = luffy.memories.create!(title:"空島",date:Date.new(2018-7-1),description:"へそ！まさかの空に縞があった！モンブランの伝説、黄金の伝説、数々の謎が秘める中、神を名乗るエネルが何やらゲームを始める")
memory4.hyle_memories.create!(hyle:zoro)
memory4.hyle_memories.create!(hyle:nami)
memory4.hyle_memories.create!(hyle:sanji)
memory4.hyle_memories.create!(hyle:usopp)
memory4.hyle_memories.create!(hyle:chopper)
memory4.hyle_memories.create!(hyle:robin)
memory4.hyle_memories.create!(hyle:enel)
