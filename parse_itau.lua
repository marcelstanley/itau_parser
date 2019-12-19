#!/usr/local/bin/lua

--
-- Copyright (c) Marcel Moura. All rights reserved.
--

if #arg ~= 2 then
  print('Usage:', arg[0]..' <input csv file> <output csv file>')
  os.exit()
end

header = {
  ',Change or add categories by updating the Expenses and Income tables in the Summary sheet.,,,,,,,,',
  ',Expenses,,,,,Income,,,',
  ',,,,,,,,,',
  ',Date,Amount,Description,Category,,Date,Amount,Description,Category',
}
income = {}
expenses = {}

function parse_line(inline)
  discard, orig_date, entry, orig_amount = string.match(inline, "((%d%d/%d%d/%d%d%d%d);([^;]+);([-,%w]+))")

  date = string.gsub(orig_date, '((%d%d)/(%d%d)/(%d%d%d%d))', '%3/%2/%4');
  amount = string.gsub(orig_amount,',','.')

  if tonumber(amount) >= 0 then
    table.insert(income, date..','..amount..','..entry) 
  else
    table.insert(expenses, date..','..math.abs(amount)..','..entry) 
  end
end

function parse_file(infile, outfile)
  input = io.open(infile)
  io.input(input)

  line = io.read()
  while line ~= nil do
    parse_line(line)
    line = io.read()
  end

  io.close(input)
end

function print_line(line)
  if line ~= nil then io.write(line..'\n') end
end

function print_file(outfile)
  output = io.open(outfile, 'w+')
  io.output(output)
  
  print_line(header[1])
  print_line(header[2])
  print_line(header[3])
  print_line(header[4])

  if #expenses >= #income then
    i = 1
    while i <= #expenses do
      line = ','..expenses[i]..',Other'
      if i <= #income then
        line = line..',,'..income[i]..',Other'
      else
        line = line..',,,,,'
      end
      print_line(line)
      i = i + 1
    end
  else

  end  

  io.close(output)
end

parse_file(arg[1])
print_file(arg[2])
