require('spec_helper')

describe(Task) do
  describe(".all") do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to an array of saved tasks") do
      test_task = Task.new({:description => "scrub the zebra", :list_id => 1, :due_date => '2016-04-01'})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe('#description') do
    it('lets you give a description') do
      test_task = Task.new({:description => "scrub the zebra", :list_id => 1, :due_date => '2016-04-01'})
      expect(test_task.description()).to (eq("scrub the zebra"))
    end
  end

  describe("#list_id") do
    it("lets your read the list ID out") do
      test_task = Task.new({:description => "scrub the zebra", :list_id => 1, :due_date => '2016-04-01'})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description") do
      task1 = Task.new({:description => "scrub the zebra", :list_id => 1, :due_date => '2016-01-01'})
      task2 = Task.new({:description => "scrub the zebra", :list_id => 1, :due_date => '2016-01-01'})
      expect(task1).to(eq(task2))
    end
  end

  describe("#sort") do
    it("sorts task by due date") do
      task1 = Task.new({:description => "scrub the zebra", :list_id => 1, :due_date => "2016-08-03"})
      task2 = Task.new({:description => "wash the giraffe", :list_id => 2, :due_date => '2016-08-02'})
      task1.save()
      task2.save()
      expect(Task.sort().first()).to(eq(task2))
    end
  end

end
