# A class, like in java
class Bug

    #Constructor
    def initialize( max ) #initialize max to parameter
        @number = 0 #the current number of bugs
        @max = max #the max number of bugs before the programmer gives up
        @seed = Random.new_seed #The seed we use so that the file and stdout are the same
    end

    def sing #Spawn threads to sing to a file and to stdout
        t1 = Thread.new{sing_bug()} #Have a thread sing to stdout
        t2 = Thread.new{sing_file()} #Have a thread sing to fout
        t1.join() #Join t1 so the progrma can end
        t2.join() #Join t2 so the program can end
    end

    def sing_file
        curr_num = 1
        prng = Random.new(@seed)  #Generate rng
        file_open = File.open("out.txt","w")
        while curr_num < @max #loop as long as there are less bugs than the programmer's limit
            if curr_num == 1 #Case for printing 1 bug
                file_open.write(factor(curr_num) + " line of text on the screen,  #{factor(curr_num)} line.\n") #Note the #{factor...} lets us use a function inline with a ruby string
            else #Case for printing multiple bugs
                file_open.write("#{factor(curr_num)} lines of text on the screen, #{factor(curr_num)} lines.\n")
            end

            curr_num = curr_num + prng.rand(10) #Removing one bug reveals a random amount of other bugs embedded in the program

            if curr_num == 1 #Case for printing one bug
                file_open.write("Print it out, stand up and shout, #{factor(curr_num)} more line of text on the screen!\n")
            else #Case for printing multiple bugs
                file_open.write("Print it out, stand up and shout, #{factor(curr_num)} more lines of text on the screen!\n")
            end

            print ""
        end

        file_open.close()
        STDERR.puts "File finished"
    end

    def sing_bug
        curr_num = 1
        prng = Random.new(@seed) #Generate rng
        while curr_num < @max #loop as long as there are less bugs than the programmer's limit
            if curr_num == 1 #Case for printing 1 bug
                puts "#{factor(curr_num)} bad bug in the file, #{factor(curr_num)} bad bug."
            else #Case for printing multiple bugs
                puts "#{factor(curr_num)} bad bugs in the file, #{factor(curr_num)} bad bugs."
            end

            curr_num = curr_num + prng.rand(10) #Removing one bug reveals a random amount of other bugs embedded in the program

            if curr_num == 1 #Case for printing one bug
                puts "Take it down, debug it down, #{factor(curr_num)} more bug in the file!"
            else #Case for printing multiple bugs
                puts "Take it down, debug it down, #{factor(curr_num)} more bugs in the file!"
            end

            print ""

            if curr_num < @max #Sleep for dramatic effect as long as we have more to print
                sleep 1 #Sleep for one second
            end
        end #End while loop

        STDERR.puts "Bugs finished"
        return curr_num #Return the total number of bugs
    end #End the sing method

    def factor(n)
        prime_factors = []
        prime = 2

        if n < 2
            return "()"
        end
        while (n % 2 == 0)
            prime_factors.push(2)
            n /=2
        end

        i = 3
        j = n
        while i <= j
            while j % i == 0
                prime_factors.push(i)
                j /= i
            end
            i += 1
        end
        return "(" + prime_factors.join("*") + ")"
    end

end #End the Bug class



print "How many bugs? " #Prompt the user
num = Integer(gets.chomp) #ask for how many lines. Then set it to a variable

bug = Bug.new(num) #Create a buggy program
bug.sing #Exactly what it says on the tin
