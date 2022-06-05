从命令行删除项目：
gitlab-rails console
route = Route.find_by("path LIKE '%unii-lab-job%'")
route.delete
route.save
projects = Project.where(path: 'unii-lab-job');
projects[0].delete
projects[0].save



route = Route.find_by("path LIKE '%unii-agent-tuijian-taobao-java%'")
route.delete
route.save
projects = Project.where(path: 'unii-agent-tuijian-taobao-java');
projects[0].delete
projects[0].save


 Project.find_by_full_path('argszero/cookie-demo')
 Project.find_by_full_path('argszero/unii-agent-tuijian-taobao-java')

Route.find_by("path LIKE '%cookie-demo%'")
Route.find_by("path LIKE '%unii-agent-tuijian-taobao-java%'")


Project.find_by_sql("SELECT p.id,p.name FROM projects ")

Project.all.map{ |p| [p.id, p.name, p.full_path] } 

[
  [ 137, 'unii-agent-baixiu-java', 'argszero/unii-agent-baixiu-java' ],
  [ 125, 'testnode', 'argszero/testnode' ],
  [ 132, 'unii-lab-job', 'argszero/unii-lab-job' ],
  [ 155, 'cookie-demo', 'argszero/cookie-demo' ],
  [ 152, 'lab-open-taobao-java', 'argszero/lab-open-taobao-java' ],
  [ 151, 'Dolphinscheduler', 'argszero/dolphinscheduler' ],
  [ 154, 'taoke_slide_220208', 'argszero/taoke_slide_220208' ],
  [ 22, 'unii-third-gateway', 'argszero/unii-third-gateway' ],
  [ 97, 'test', 'argszero/test' ],
  [ 112, 'unii-back-gateway', 'argszero/unii-back-gateway' ],
  [ 119, 'lab-open-taobao', 'argszero/lab-open-taobao' ]
]


Route.all.map{ |r| [r.id, r.name]};

[
  [ 9, 'argszero' ],
  [ 35, 'argszero / unii-third-gateway' ],
  [ 168, 'argszero / unii-back-gateway' ],
  [ 138, 'argszero / test' ],
  [ 175, 'argszero / lab-open-taobao' ],
  [ 182, 'argszero / testnode' ],
  [ 191, 'argszero / unii-lab-job' ],
  [ 198, 'argszero / unii-agent-baixiu-java' ],
  [ 216, 'argszero / Dolphinscheduler' ],
  [ 217, 'argszero / lab-open-taobao-java' ],
  [ 219, 'argszero / taoke_slide_220208' ]
]

projects = Project.where(path: 'cookie-demo');
projects[0].delete
projects[0].save