comment * ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
           Include file for procedures in the MASM32 library
          ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл *

; for both --> arg num, buffer
ArgCl  PROTO :DWORD,:DWORD   ; GUI mode version
ArgClC PROTO :DWORD,:DWORD   ; console mode version
GetCL PROTO :DWORD,:DWORD

Alloc       PROTO :DWORD
Free        PROTO :DWORD

comment * --------------------------
        numeric and text conversions
        ---------------------------- *
a2dw   PROTO :DWORD
atodw  PROTO :DWORD          ; return value in eax
htodw  PROTO :DWORD          ; return value in eax
dwtoa  PROTO :DWORD,:DWORD   ; value - buffer
dw2a   PROTO :DWORD,:DWORD
dw2hex PROTO :DWORD,:DWORD
dw2ah  PROTO :DWORD,:DWORD

GetErrDescription PROTO :DWORD

comment * -----------------------------------
        string and floating point conversions
        ------------------------------------- *
FloatToStr  proto stdcall fpin:QWORD, szDbl:PTR CHAR
FloatToStr2	proto	stdcall fpin:QWORD, szDbl:PTR CHAR
StrToFloat	proto	stdcall szIn:PTR BYTE, fpout:PTR DWORD

comment * ---------------
        search algorithms
        ----------------- *
InString  PROTO :DWORD,:DWORD,:DWORD ; StartPos - lpszString - lpszSubStr
BinSearch PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD      ; classic scanner

; Boyer Moore based algorithms
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BMBinSearch  PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD   ; complete BM
BMHBinsearch PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD   ; horspool variation
SBMBinSearch PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD   ; simplified version
WordCount    PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD

comment * ---------------------------
        encryption algorithms for
        "one shot" or "one pass" pads
        ----------------------------- *
XorData PROTO :DWORD,:DWORD,:DWORD,:DWORD
RolData PROTO :DWORD,:DWORD,:DWORD,:DWORD
RorData PROTO :DWORD,:DWORD,:DWORD,:DWORD

StrLen PROTO :DWORD ; Agner Fog's high speed string length algo

comment * ------------------------------------
        zero terminated string procedures have
        been renamed for consistency. Equates
        to the old names are below.
        -------------------------------------- *

    szappend    PROTO :DWORD,:DWORD,:DWORD
    szCatStr    PROTO :DWORD,:DWORD
    szCmp       PROTO :DWORD,:DWORD
    szCmpi      PROTO :DWORD,:DWORD,:DWORD
    szCopy      PROTO :DWORD,:DWORD
    szLeft      PROTO :DWORD,:DWORD,:DWORD
    szLen       PROTO :DWORD
    szLower     PROTO :DWORD
    szLtrim     PROTO :DWORD,:DWORD
    szMid       PROTO :DWORD,:DWORD,:DWORD,:DWORD
    szMultiCat  PROTO C :DWORD,:DWORD,:VARARG
    szRemove    PROTO :DWORD,:DWORD,:DWORD
    szRev       PROTO :DWORD,:DWORD
    szRight     PROTO :DWORD,:DWORD,:DWORD
    szRtrim     PROTO :DWORD,:DWORD
    szTrim      PROTO :DWORD
    szUpper     PROTO :DWORD

comment * ---------------------------------
        the equates for the old names must
        be put after the prototypes for the
        procedures they are mapped to.
        ----------------------------------- *

    lnstr   equ <szLen>
    cmpstr  equ <szCmp>
    cmpsi   equ <szCmpi>
    revstr  equ <szRev>
    lcase   equ <szLower>
    ucase   equ <szUpper>
    ltrim   equ <szLtrim>
    rtrim   equ <szRtrim>
    trim    equ <szTrim>
    lstr    equ <szLeft>
    rstr    equ <szRight>
    midstr  equ <szMid>
; -----------------------------------------

shell PROTO :DWORD

StripRangeI PROTO :DWORD,:DWORD,:BYTE,:BYTE
StripRangeX PROTO :DWORD,:DWORD,:BYTE,:BYTE

MemCopy PROTO :DWORD,:DWORD,:DWORD  ; source - dest - length
memfill PROTO :DWORD,:DWORD,:DWORD

GetAppPath   PROTO :DWORD     ; buffer has app path
NameFromPath PROTO :DWORD,:DWORD
GetPathOnly  PROTO :DWORD,:DWORD

exist       PROTO :DWORD
filesize    PROTO :DWORD

FrameCtrl   PROTO :DWORD,:DWORD,:DWORD,:DWORD
FrameWindow PROTO :DWORD,:DWORD,:DWORD,:DWORD
FrameGrp    PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD

Frame3D PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
line    PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
circle  PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

DisplayBmp   PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
DisplayIcon  PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
VerticalTile PROTO :DWORD,:DWORD,:DWORD
SetBMcolor   PROTO :DWORD,:DWORD

BmpButton    PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

StdOut       PROTO :DWORD
StdIn        PROTO :DWORD,:DWORD
locate       PROTO :DWORD,:DWORD
ClearScreen  PROTO
StripLF      PROTO :DWORD

BrowseForFolder PROTO :DWORD,:DWORD,:DWORD,:DWORD
FontDialog      PROTO :DWORD,:DWORD,:DWORD
ColorDialog     PROTO :DWORD,:DWORD,:DWORD
PageSetupDialog PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
PrintDialog     PROTO :DWORD,:DWORD,:DWORD

Read_File_In    PROTO :DWORD,:DWORD
ofCallBack      PROTO :DWORD,:DWORD,:DWORD,:DWORD
Write_To_Disk   PROTO :DWORD,:DWORD
sfCallBack      PROTO :DWORD,:DWORD,:DWORD,:DWORD
RichEd1         PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
RichEd2         PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

GetPercent      PROTO :DWORD,:DWORD
IntMul          PROTO :DWORD,:DWORD
IntDiv          PROTO :DWORD,:DWORD
IntSqrt         PROTO :DWORD

nrandom         PROTO :DWORD
nseed           PROTO :DWORD

; ---------------------------------
; prototypes for pre-built dialogs
; ---------------------------------
GetTextInput    PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
AboutBox        PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
GetFile         PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
LoadList        PROTO :DWORD,:DWORD
IPtoString      PROTO :DWORD,:DWORD
GetIP           PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD

    MakeIP MACRO val1,val2,val3,val4
        mov ah, val1
        mov al, val2
        rol eax, 16
        mov ah, val3
        mov al, val4
      EXITM <eax>
    ENDM

; ----------------------------------------
; Ernie Murphy's image loading procedures
; ----------------------------------------
BitmapFromFile      PROTO :DWORD
BitmapFromMemory    PROTO :DWORD,:DWORD
BitmapFromResource  PROTO :DWORD,:DWORD

; -------------------
; file IO procedures
; -------------------
read_disk_file  PROTO :DWORD,:DWORD,:DWORD
write_disk_file PROTO :DWORD,:DWORD,:DWORD

; ------------------------------
; memory mapped file procedures
; ------------------------------
CloseMMF  PROTO :DWORD,:DWORD
CreateMMF PROTO :DWORD,:DWORD,:DWORD,:DWORD

; ----------------
; sort procedures
; ----------------
nrQsortA PROTO :DWORD,:DWORD
nrQsortD PROTO :DWORD,:DWORD

CombSortA PROTO :DWORD,:DWORD
CombSortD PROTO :DWORD,:DWORD

testreg PROTO

HexDump   PROTO :DWORD,:DWORD,:DWORD
AsciiDump PROTO :DWORD,:DWORD,:DWORD

; ------------------------------------------
; ascii and 32 bit long integer conversions
; ------------------------------------------
atol PROTO :DWORD
ltoa PROTO :DWORD,:DWORD

; ----------------------------
; File open and close dialogs
; ----------------------------
OpenFileDialog PROTO :DWORD, :DWORD, :DWORD, :DWORD
SaveFileDialog PROTO :DWORD, :DWORD, :DWORD, :DWORD

a2wc        PROTO :DWORD

; ----------------
; array procedures
; ----------------
arr_add         PROTO :DWORD,:DWORD,:DWORD
arr_mul         PROTO :DWORD,:DWORD,:DWORD
arr_sub         PROTO :DWORD,:DWORD,:DWORD
create_array    PROTO :DWORD,:DWORD

byte_count  PROTO :DWORD,:DWORD,:DWORD

load_drives PROTO :DWORD

udw2str PROTO :DWORD,:DWORD
ustr2dw PROTO :DWORD


