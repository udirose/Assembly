#include <avr/io.h>
#include "asmMacros.s"  // Include macros to print log messages or a single register
.data
globalasm: .byte 0

.text


.global updateGlobal
updateGlobal:
  // TODO: void updateGlobal(byte a)
  mov r22,r24
  mov r23,r25
  call getGlobal
  add r24, r22
  adc r25, r23

  ldi r30, lo8(globalasm)
  ldi r31, hi8(globalasm)
  st Z, r24
  
  ret


.global getGlobal
getGlobal:
  // TODO: uint8_t getGlobal()
  ldi r30, lo8(globalasm)
  ldi r31, hi8(globalasm)
  ld r24, Z
  ret 


.global cStringLength
cStringLength:
  // TODO: uint8_t cStringLength(const char aString[])
  ldi r18,0 //i

  mov r30, r24
  mov r31, r25
  
  startString:

  ld r22, Z+
  cp r22,r1
  breq endString
  inc r18
  jmp startString
  

  endString:
  mov r24,r18
  ret

.global sumArrays
sumArrays:
  // TODO: void sumArrays(uint8_t *a, uint8_t *b, uint8_t *c, byte length)

  push r14
  push r16
  push r28
  push r29

  ldi r19,0 //i


  //*a is X
  mov r26,r24
  mov r27,r25

  //*b is Y
  mov r28,r22
  mov r29,r23

  //*c is Z
  mov r30,r20
  mov r31,r21

  sumLoop:


  ld r16, X+
  ld r14, Y+
  add r14,r16
  st Z+, r14
  

  inc r19
  cp r19,r18
  brsh sumEnd
  jmp sumLoop

  sumEnd:


  pop r29
  pop r28
  pop r16
  pop r14

  
  
  ret

.global dot
dot:
  // TODO uint16_t dot(uint8_t *a, uint8_t *b, byte length)

  push r14
  push r16
  push r28
  push r29

  ldi r30,0 //sum
  ldi r31,0 //sum
  ldi r18,0 //i

  //*a is X
  mov r26,r24
  mov r27,r25

  //*b is Y
  mov r28,r22
  mov r29,r23

  dotLoop:


  ld r16, X+
  ld r14, Y+
  mul r14,r16
  add r30,r0
  adc r31,r1
  clr r0
  clr r1

  
  inc r18
  cp r18,r20
  brsh dotEnd
  jmp dotLoop

  dotEnd:


  mov r24,r30
  mov r25,r31

  pop r29
  pop r28
  pop r16
  pop r14

  
  ret
