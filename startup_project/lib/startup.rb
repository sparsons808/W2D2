require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries_hash)
        @name = name
        @funding = funding
        @salaries = salaries_hash
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(dif_startup)
        self.funding > dif_startup.funding
    end

    def hire(employee_name, title)
        if !valid_title?(title)
            raise "error, title not valid"
        elsif valid_title?(title)
            @employees << Employee.new(employee_name, title)
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding > @salaries[employee.title]
            employee.pay(@salaries[employee.title])
            @funding = @funding - @salaries[employee.title]
        else
            raise "error, not enough funding to pay employee"
        end
    end

    def payday
        @employees.each { |employee| pay_employee(employee) }
    end

    def average_salary
        salaries = []
        @employees.each do |employee|
            salaries << @salaries[employee.title]
        end
        avg = salaries.sum / salaries.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding = self.funding + startup.funding

        startup.salaries.each do |title, pay|
            if !self.salaries.has_key?(title)
                self.salaries[title] = pay
            end
        end

        @employees = self.employees + startup.employees

        startup.close
    end
end
