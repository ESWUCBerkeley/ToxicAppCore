package eswucberkeley.toxics.scanner;

import java.awt.Image;
import ij.ImagePlus;
import ij.process.ImageConverter;
import ij.process.ImageProcessor;

/**
 * Created by Yifeng Ding on 3/8/2017.
 */
public class ScannerUtils {

    /**
     * Checks if UPC follows standard UPC checksum
     * @param upc
     * @return
     */
    private static boolean upcChecksum(int[] upc) {
        if (upc.length != 12) {
            return false;
        }
        int sum = 0;
        for (int i = 0; i < 12; i++) {
            if (i % 2 == 0) {
                sum += upc[i] * 3;
            } else {
                sum += upc[i];
            }
        }
        return (sum % 10) == 0;
    }

    /**
     * Tries to extract a UPC from an image
     * Assumes the barcode is near parallel with bottom and is centered
     * @param barcode assumes input is standard java image
     * @return string containing the UPC if valid, else null
     */
    public static String scanUPC(Image barcode) {
        ImagePlus b = new ImagePlus(null, barcode);
        ImageConverter converter = new ImageConverter(b);
        converter.convertToGray8();
        /* YOUR CODE HERE */

        return null;
    }

}
