# Segmented-Single-Insdel-Edit-Error-Correcting-Codes_MATLAB
This is the MATLAB code for the paper `Marker+Codeword+Marker: A Coding Structure for Segmented Single-Insdel/-Edit Channels' by Zhen Li, Xuan He and Xiaohu Tang


To test our code, open `TestInsdel.m' or `TestInsdel.m',

	* The inputs are the Number of segments t and the Number of cycles f.

	* The output is `isAllZero'.

If the logical number is `1', the decoded results (collected as `Decoded_VT') are the same as the original transmitted VT codewords. All the errors are corrected.
If the logical number is `0', the decoding fails.

The roles for each documents.

	1) RandomInsdel/RandomEdit.m	        Generates the random errors in each segments

	2) VT1/VT2.m				The encoders of VT codes

	3) SegInsdelECC/SegEditECC.m		Encoders based on the marker-structure

	4) SegInsdelDec/SegEditDec.m		Decoders based on the proof

	5) TestInsdel/TestEdit.m		The script for testing decoding process
