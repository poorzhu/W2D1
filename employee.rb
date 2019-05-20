class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :name, :title, :salary, :boss, :employees

  def initialize(name, title, salary, boss = nil, *employees)
    # @name = name
    # @title = title
    # @salary = salary
    # @boss = boss
    super(name, title, salary, boss = nil)
    @employees = employees
  end

  def bonus(multiplier)
    total_employee_salary * multiplier
  end

  def total_employee_salary
    return salary if employees.empty?
    total_salary = 0 
    @employees.each do |employee|
      total_salary += (employee.employees.empty? ? employee.salary : employee.total_employee_salary)
    end 
    total_salary
  
  end 
end

ned = Manager.new('Ned', 'Founder', 1000000)
darren = Manager.new('Darren', 'TA Manager', 78000, ned)
shawna = Employee.new('Shawna', 'TA', 12000, darren)
david = Employee.new('David', 'TA', 10000, darren)

ned.employees << darren
darren.employees << shawna << david

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000