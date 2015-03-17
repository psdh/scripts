import sys
import re

def main():
    f = open(sys.argv[1], "r")
    k = f.read()
    f.close()
    k = re.sub(r'\n%build', '\n#undefine _hardened_build\n%build', k)
    f = open(sys.argv[1], "w")
    f.write(k)
    f.close()

if __name__ == "__main__":
    main()
