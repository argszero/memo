从命令行删除项目：
gitlab-rails console
route = Route.find_by("path LIKE '%unii-lab-job%'")
route.delete
route.save
projects = Project.where(path: 'unii-lab-job');
projects[0].delete
projects[0].save