#!/usr/local/bin/lua

if #arg ~= 2 then
  print('Usage:', arg[0]..' <input csv file> <output csv file>')
  os.exit()
end

print('Converting '..arg[1]..' to '..arg[2]..'...')

input = io.open(arg[1])
io.input(input)

output = io.open(arg[2], 'w+')
io.output(output)

line = io.read()
while line ~= nil do
  io.write(line)
  io.write('\n')
  line = io.read()
end

io.close(input)
io.close(output)

print('DONE')
