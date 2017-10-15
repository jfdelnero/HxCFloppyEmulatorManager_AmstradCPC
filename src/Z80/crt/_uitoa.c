
void uitoa(unsigned int value, char* string, unsigned char radix)
{
  signed char index = 0, i = 0;

  /* generate the number in reverse order */
  do {
    string[index] = '0' + (value % radix);
    if (string[index] > '9')
        string[index] += 'A' - '9' - 1;
    value /= radix;
    ++index;
  } while (value != 0);

  /* null terminate the string */
  string[index--] = '\0';

  /* reverse the order of digits */
  while (index > i) {
    char tmp = string[i];
    string[i] = string[index];
    string[index] = tmp;
    ++i;
    --index;
  }
}