class GetUserJob < ApplicationJob
  queue_as :default

  before_perform do |job|
    Role.find(1).update(description: "on_progress")
  end

  before_enqueue do |job|
    p "masuk sini dulu sbelum enqueue"
    counter = 0
    role = Role.find(1)
    if role.description == "failed" && counter <= 3
      Role.add_role
      counter += 1
    else
      role.update(description: 'totally_failed_bro')
    end
  end

  def perform(*args)
    # Do something later
    counter = 0
    role = Role.find(1)
    user = ApiRequest.http_get("https://jsonplaceholder.typicode.com/todos/0")
    if user.status == 200
      role.update(description: "success")
    else
      role.update(description: "failed")
    end
  end
end
