#!/usr/local/bin/lua

--
-- Copyright (c) Marcel Moura. All rights reserved.
--

if #arg ~= 2 then
  print('Usage:', arg[0]..' <input csv file> <output csv file>')
  os.exit()
end

function convert_line(inline)
  discard, orig_date, entry, orig_amount = string.match(inline, "((%d%d/%d%d/%d%d%d%d);([^;]+);([-,%w]+))")

  date = string.gsub(orig_date, '((%d%d)/(%d%d)/(%d%d%d%d))', '%3/%2/%4');
  amount = string.gsub(orig_amount,',','.')

  return date..';'..entry..';'..amount  
end

function convert_file(infile, outfile)
  print('Converting '..infile..' to '..outfile..'...')

  input = io.open(infile)
  io.input(input)

  output = io.open(outfile, 'w+')
  io.output(output)

  line = io.read()
  while line ~= nil do
    io.write(convert_line(line))
    io.write('\n')
    line = io.read()
  end

  io.close(input)
  io.close(output)

  print('DONE')

end

convert_file(arg[1], arg[2])
