/**
 * CS 2110 Spring 2024 HW1
 * Part 2 - Coding with bases
 *
 * @author Sreehitha Kalagara
 *
 * Global rules for this file:
 * 
 * - You cannot use multiplication, division, and modulus operators
 * - You cannot use nested loops
 * - You cannot declare file-level variables
 * - You cannot use switch statements
 * - You cannot use the unsigned right shift operator (>>>)
 * - You cannot use helper methods, call any other methods, or use recursion.
 * 
 * - You may not use more than 2 conditionals per method. Conditionals are
 *   if-statements, if-else statements, or ternary expressions. The else block
 *   associated with an if-statement does not count toward this sum.
 * - You may not use more than 2 loops per method. This includes
 *   for loops, while loops and do-while loops.
 * - The only Java API methods you are allowed to invoke are:
 *     String.length()
 *     String.charAt()
 * - You may not invoke the above methods from String literals.
 *     Example: "12345".length()
 * - When concatenating numbers with Strings, you may only do so if the number
 *   is a single digit.
 */
public class Bases {
    /**
     * Convert a String containing ASCII characters (in binary) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid binary numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: binaryStringToInt("110"); // => 6
     */
    public static int binaryStringToInt(String binary) {
        int result = 0;
        for (int i = 0; i < binary.length(); i++) {
            if (binary.charAt(i) != '0') {
                result += 1 << (binary.length() - 1 - i);
            }
        }
        return result;
    }

    /**
     * Convert a String containing ASCII characters (in decimal) to an int.
     *
     * You do not need to handle negative numbers. The Strings we will pass in
     * will be valid decimal numbers, and able to fit in a 32-bit signed integer.
     *
     * Example: decimalStringToInt("46"); // => 46
     */
    public static int decimalStringToInt(String decimal) {
        int result = 0;
        for (int i = 0; i < decimal.length(); i++) {
            if ((decimal.charAt(i)) - 48 != 0) {
                result = (result << 3) + (result << 1);
                result += decimal.charAt(i) - 48;
            }
        }
        return result;
    }
    /**
     * Convert a String containing ASCII characters (in binary) to an a String containing ASCII characters (in octal).
     * The input String will only contain the numbers 0 and 1.
     * You may assume that the length of the binary String is divisible by 3.
     *
     * Example: binaryStringToOctalString("110100"); // => "64"
     */
    public static String binaryStringToOctalString(String binary) {
        String result = "";
        for (int i = 0; i < binary.length(); i += 3) {
            int triple = 0;
            triple += ((int)binary.charAt(i) - 48) << 2;
            triple += ((int)binary.charAt(i + 1) - 48) << 1;
            triple += ((int)binary.charAt(i + 2) - 48);
            result += triple;
        }
        return result;
    }

    /**
     * Convert a int into a String containing ASCII characters (in hex).
     *
     * You do not need to handle negative numbers.
     * The String returned should contain the minimum number of characters
     * necessary to represent the number that was passed in.
     *
     * Example: intToHexString(30); // => "1E"
     */
    public static String intToHexString(int hex) {
        String result = "";
        char toAdd;
        int x;
        do {
            x = (hex & 15);
            if (x > 9) {
                toAdd = (char) ('A' + (x - 10));
            } else {
                toAdd = (char) ('0' + x);
            }
            result = toAdd + result;
            hex = hex >> 4;
        } while (hex != 0);
        return result;
    }

    /**
     * Convert a String containing ASCII characters representing a number in
     * hex into a String containing ASCII characters that represent that same
     * value in binary. The returned binary String should not have any leading
     * zeros, even if there are in the input hex String. If the hex String
     * evaluates to zero, then return the equivalent of zero in binary.
     *
     * The output String should only 0's and 1's.
     *
     * Example: hexStringToBinaryString("0F32A65C"); => "1111001100101010011001011100"
     */
    public static String hexStringToBinaryString(String hex) {

        int number = 0;
        int count = 0;
        for (int i = 0; i < hex.length(); i++) {
            int y = hex.charAt(hex.length() - i - 1);
            if (y > 59) {
                number += (y - 55) << count;
            } else {
                number += (y - 48) << count;
            }
            count += 4;
        }
        String string = "";
        do {
            if ((number & 1) == 1) {
                string = "1" + string;
            } else {
                string = "0" + string;
            }
            number = number >> 1;
        } while (number > 0);
        return string;
    }
}