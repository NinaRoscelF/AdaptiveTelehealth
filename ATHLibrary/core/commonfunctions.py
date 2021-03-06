
import datetime
import os
# import fpdf

from robot.libraries.BuiltIn import BuiltIn
from robot.api import logger
# from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
# from pdfminer.converter import TextConverter
# from pdfminer.layout import LAParams
# from pdfminer.pdfpage import PDFPage
# from cStringIO import StringIO
from ATHLibrary.core.ath_exceptions import ValidationFailedError
# import hashlib

class CommonFunctions():
    '''This class contains Common Functions such as 
    handling string, date, boolean etc. used across framework
    '''

    @staticmethod
    def get_os_name():
        '''use this function to get the os_name from robot framework.'''
        # FYI, from http://docs.python.org/library/sys.html#sys.platform
        # Linux (2.x and 3.x)    'linux2'
        # Windows    'win32'
        # Windows/Cygwin    'cygwin'
        # Mac OS X    'darwin'from robot.api import logger
        if os.sys.platform.startswith('linux'):
            return 'linux'  # preparing for python 3.3 :P
        return os.sys.platform
    
    @staticmethod
    def make_bool(*args):
        '''Converts strings, ints, etc. to boolean values, since all RF scripts pass
        parameters to selenium as strings.
        Usage, multiple and single vars:
        (positive_test, required) = self.make_bool(positive_test, required)
        positive_test = self.make_bool(positive_test)
        '''
        if len(args) == 1:
            return BuiltIn().convert_to_boolean(args[0])
        return tuple(BuiltIn().convert_to_boolean(arg) for arg in args)
    
    @staticmethod
    def decode_utf8(strvalue):
        '''Decode any string using utf8. 
        This is required when we use a text which is not in English language'''
        return strvalue.decode('utf8')
    
    @staticmethod
    def encode_utf8(strvalue):
        '''Decode any string using utf8. 
        This is required when we use a text which is not in English language'''
        return strvalue.encode('utf-8')
    
    @staticmethod
    def convert_upper(stringval):
        return stringval.upper()
    
    @staticmethod
    def convert_lower(stringval):
        return stringval.lower()    


    @staticmethod
    def write_to_pdf(text, path, filename):
        # pip install fpdf2
        import fpdf
        outdir = os.path.join(path, filename)
        pdf = fpdf.FPDF(format='letter')
        pdf.add_page()
        pdf.set_font("Arial", size=12)
        # width = 200, heigh=10, align=L Left
        pdf.multi_cell(200,10,txt=text,align="L")
        pdf.output(outdir)

    @staticmethod
    def extractPDFcontents(path):
        '''Verify PDF contents
        '''
        rsrcmgr = PDFResourceManager()
        retstr = StringIO()
        codec = 'utf-8'
        laparams = LAParams()
        device = TextConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
        fp = file(path, 'rb')
        interpreter = PDFPageInterpreter(rsrcmgr, device)
        password = ""
        maxpages = 0
        caching = True
        pagenos=set()

        for page in PDFPage.get_pages(fp, pagenos, maxpages=maxpages, password=password,caching=caching, check_extractable=True):
            interpreter.process_page(page)

        text = retstr.getvalue()

        fp.close()
        device.close()
        retstr.close()
        return text

    # @staticmethod
    # def getmd5hash(file, block_size=2**20):
    #     md5 = hashlib.md5()
    #     while True:
    #         data = file.read(block_size)
    #         if not data:
    #             break
    #         md5.update(data.encode('utf8'))
    #     logger.info("for %s: %s"%(file, md5.hexdigest()))
    #     return md5.hexdigest()


    # @staticmethod
    # def compareFileMD5(file1, file2):
    #     if (CommonFunctions.getmd5hash(open(file1, 'r')) == CommonFunctions.getmd5hash(open(file2, 'r'))):
    #         logger.info("Files Matched!")

    #     if not(CommonFunctions.getmd5hash(open(file1, 'r')) == CommonFunctions.getmd5hash(open(file2, 'r'))):
    #         raise ValidationFailedError("Files Not Matched! - file 1 has %s and file 2 has %s"%(CommonFunctions.getmd5hash(open(file1, 'r')),CommonFunctions.getmd5hash(open(file2, 'r'))))

    def writefile(self, filenamewithpath, testdata):
        directory = os.path.dirname(filenamewithpath)
        if not os.path.exists(directory):
            os.makedirs(directory)
        with open(filenamewithpath, 'w+') as dataobj:
            dataobj.write(testdata)

    def readfile(self, filenamewithpath):
        with open(filenamewithpath, 'r') as dataobj:
            value = dataobj.read()                  
        return value

    def removefile(self, filenamewithpath):
        os.unlink(filenamewithpath)   

