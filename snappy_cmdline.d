import snappy;
import std.stdio;
import std.encoding;

void usage(string[] args) {
  writeln("Usage: ", args[0], " x|c inputFile outputFile");
}

int main(string[] args) {
  if (args.length != 4) {
    usage(args);
    return 1;
  }
  auto mode = args[1];
  auto inputFileName = args[2];
  auto outputFileName = args[3];

  auto inputFile = File(inputFileName, "r");
  auto h = new byte[inputFile.size()];
  auto data = inputFile.rawRead(h);
  byte[] res;
  if (mode == "x") {
    res = Snappy.uncompress(data);
  } else if (mode == "c") {
    res = Snappy.compress(data);
  } else {
    usage(args);
    return 2;
  }

  auto outputFile = File(outputFileName, "w");
  outputFile.rawWrite(res);

  writeln(inputFileName, "(", data.length, ")", "->", outputFileName, "(", res.length, ")");

  return 0;
}