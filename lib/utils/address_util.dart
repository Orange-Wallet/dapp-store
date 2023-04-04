class AddressUtil {
  AddressUtil._();

  static String getClippedAddress(String addr) {
    return "${addr.substring(0, 6)}...${addr.substring(addr.length - 6)}";
  }
}
