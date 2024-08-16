	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 4
	.eabi_attribute 18, 4
	.file	"matrixDiagV7.c"
	.global	__aeabi_i2d
	.global	__aeabi_dcmpeq
	.text
	.align	2
	.global	checkOffDiagonalZeros
	.type	checkOffDiagonalZeros, %function
checkOffDiagonalZeros:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r7, r0
	mov	r6, r1
	mov	r8, r0, asl #2
	mov	r5, #0
	b	.L2
.L5:
	cmp	r5, r4
	beq	.L3
	ldr	r0, [r6, r4, asl #2]
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dcmpeq
	cmp	r0, #0
	beq	.L4
.L3:
	add	r4, r4, #1
.L8:
	cmp	r4, r7
	blt	.L5
	add	r5, r5, #1
	add	r6, r6, r8
.L2:
	cmp	r5, r7
	movge	r0, #1
	bge	.L7
.L6:
	mov	r4, #0
	b	.L8
.L4:
	mov	r0, #0
.L7:
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
	.size	checkOffDiagonalZeros, .-checkOffDiagonalZeros
	.align	2
	.global	matrixMultiply
	.type	matrixMultiply, %function
matrixMultiply:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	sub	sp, sp, #72
	mov	r6, r1
	str	r2, [sp, #4]
	mov	r1, r0
	mov	r5, #0
	b	.L11
.L12:
	ldr	r3, [ip, #0]
	mul	r2, r3, fp
	ldr	r3, [ip, #16]
	mla	r2, r3, r9, r2
	ldr	r3, [ip, #32]
	mla	r2, r3, sl, r2
	ldr	r3, [ip, #48]
	mla	r2, r3, r8, r2
	add	ip, ip, #4
	add	r3, r6, #16
	cmp	ip, r3
	str	r2, [r7], #4
	bne	.L12
	add	r5, r5, #1
	cmp	r5, #4
	add	r1, r1, #16
	beq	.L13
.L11:
	add	r3, sp, #8
	add	r7, r3, r5, asl #4
	ldr	fp, [r1, #0]
	ldmib	r1, {r9, sl}	@ phole ldm
	ldr	r8, [r1, #12]
	mov	r4, r6
	mov	ip, r6
	b	.L12
.L13:
	ldr	r1, [sp, #4]
	add	r2, sp, #8
	cmp	r1, #0
	moveq	r1, r2
	beq	.L17
.L15:
	ldr	r3, [r2, #0]
	str	r3, [r0, #0]
	ldr	r3, [r2, #4]
	str	r3, [r0, #4]
	ldr	r3, [r2, #8]
	str	r3, [r0, #8]
	add	r1, sp, #72
	ldr	r3, [r2, #12]
	add	r2, r2, #16
	cmp	r2, r1
	str	r3, [r0, #12]
	add	r0, r0, #16
	bne	.L15
	b	.L18
.L17:
	ldmia	r1, {r2, r3}	@ phole ldm
	str	r3, [r4, #4]
	ldr	r3, [r1, #8]
	str	r3, [r4, #8]
	add	r0, sp, #72
	ldr	r3, [r1, #12]
	add	r1, r1, #16
	cmp	r1, r0
	str	r2, [r4, #0]
	str	r3, [r4, #12]
	add	r4, r4, #16
	bne	.L17
.L18:
	add	sp, sp, #72
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
	.size	matrixMultiply, .-matrixMultiply
	.align	2
	.global	multiplyWithTransposed
	.type	multiplyWithTransposed, %function
multiplyWithTransposed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	sub	sp, sp, #72
	str	r1, [sp, #4]
	str	r2, [sp, #0]
	mov	r4, r0
	mov	r6, #0
	b	.L20
.L21:
	ldr	r3, [ip, #0]
	mul	r2, r3, fp
	ldr	r3, [ip, #4]
	mla	r2, r3, r9, r2
	ldr	r3, [ip, #8]
	mla	r2, r3, sl, r2
	ldr	r3, [ip, #12]
	mla	r3, r8, r3, r2
	add	r1, r1, #1
	cmp	r1, #4
	str	r3, [r7], #4
	add	ip, ip, #16
	bne	.L21
	add	r6, r6, #1
	cmp	r6, #4
	add	r4, r4, #16
	beq	.L22
.L20:
	ldr	r5, [sp, #4]
	add	r3, sp, #8
	add	r7, r3, r6, asl #4
	ldr	fp, [r4, #0]
	ldmib	r4, {r9, sl}	@ phole ldm
	ldr	r8, [r4, #12]
	mov	ip, r5
	mov	r1, #0
	b	.L21
.L22:
	ldr	r1, [sp, #0]
	add	r2, sp, #8
	cmp	r1, #0
	moveq	r1, r2
	beq	.L26
.L24:
	ldr	r3, [r2, #0]
	str	r3, [r0, #0]
	ldr	r3, [r2, #4]
	str	r3, [r0, #4]
	ldr	r3, [r2, #8]
	str	r3, [r0, #8]
	add	r1, sp, #72
	ldr	r3, [r2, #12]
	add	r2, r2, #16
	cmp	r2, r1
	str	r3, [r0, #12]
	add	r0, r0, #16
	bne	.L24
	b	.L27
.L26:
	ldmia	r1, {r2, r3}	@ phole ldm
	str	r3, [r5, #4]
	ldr	r3, [r1, #8]
	str	r3, [r5, #8]
	add	r0, sp, #72
	ldr	r3, [r1, #12]
	add	r1, r1, #16
	cmp	r1, r0
	str	r2, [r5, #0]
	str	r3, [r5, #12]
	add	r5, r5, #16
	bne	.L26
.L27:
	add	sp, sp, #72
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
	.size	multiplyWithTransposed, .-multiplyWithTransposed
	.align	2
	.global	apply_to_fixed_in_place
	.type	apply_to_fixed_in_place, %function
apply_to_fixed_in_place:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8}
	mov	r8, r0
	mov	r7, r0
.L29:
	ldr	r3, [r7, #0]
	ldr	r2, [r7, #4]
	ldr	r1, [r7, #8]
	sub	ip, r3, #-67108863
	ldr	r0, [r7, #12]
	sub	r4, r2, #-67108863
	cmp	r3, #0
	sub	ip, ip, #66846720
	sub	r5, r1, #-67108863
	movlt	r3, ip
	sub	r4, r4, #66846720
	cmp	r2, #0
	sub	r6, r0, #-67108863
	movlt	r2, r4
	sub	r5, r5, #66846720
	cmp	r1, #0
	movlt	r1, r5
	sub	r6, r6, #66846720
	cmp	r0, #0
	movlt	r0, r6
	mov	r3, r3, asr #18
	mov	r2, r2, asr #18
	mov	r1, r1, asr #18
	mov	r0, r0, asr #18
	str	r3, [r7, #0]
	str	r2, [r7, #4]
	str	r1, [r7, #8]
	str	r0, [r7, #12]
	add	r3, r8, #64
	add	r7, r7, #16
	cmp	r7, r3
	bne	.L29
	ldmfd	sp!, {r4, r5, r6, r7, r8}
	bx	lr
	.size	apply_to_fixed_in_place, .-apply_to_fixed_in_place
	.global	__aeabi_i2f
	.global	__aeabi_fdiv
	.global	__aeabi_fsub
	.global	__aeabi_fmul
	.global	__aeabi_f2d
	.global	__aeabi_dmul
	.global	__aeabi_d2f
	.align	2
	.global	getSubMatrix
	.type	getSubMatrix, %function
getSubMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 160
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	add	r3, r0, r2, asl #4
	mov	r8, r2
	add	r2, r0, r1, asl #4
	ldr	r6, [r3, r1, asl #2]
	ldr	r5, [r2, r8, asl #2]
	sub	sp, sp, #164
	str	r0, [sp, #12]
	add	r0, r5, r6
	ldr	sl, [r3, r8, asl #2]
	ldr	r7, [r2, r1, asl #2]
	mov	fp, r1
	bl	__aeabi_i2f
	mov	r4, r0
	rsb	r0, r7, sl
	bl	__aeabi_i2f
	mov	r1, r0
	mov	r0, r4
	bl	__aeabi_fdiv
	bl	atanf
	mov	r9, r0
	rsb	r0, r5, r6
	bl	__aeabi_i2f
	mov	r4, r0
	add	r0, sl, r7
	bl	__aeabi_i2f
	mov	r1, r0
	mov	r0, r4
	bl	__aeabi_fdiv
	bl	atanf
	mov	r1, r0
	mov	r0, r9
	bl	__aeabi_fsub
	mov	r1, #1056964608
	bl	__aeabi_fmul
	str	r0, [sp, #8]	@ float
	ldr	r1, [sp, #8]	@ float
	mov	r0, r9
	bl	__aeabi_fsub
	ldr	r7, .L33
	add	sl, sp, #24
	add	r9, sp, #16
	bl	__aeabi_f2d
	mov	r6, #0
	mov	r2, sl
	mov	r3, r9
	bl	sincos
	mov	r2, r6
	mov	r3, r7
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	add	r5, sp, #24
	ldmia	r5, {r4-r5}
	bl	lroundf
	mov	r2, r6
	mov	r3, r7
	str	r0, [sp, #4]
	mov	r1, r5
	mov	r0, r4
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	lroundf
	str	r0, [sp, #0]
	ldr	r0, [sp, #8]	@ float
	bl	__aeabi_f2d
	mov	r2, sl
	mov	r3, r9
	bl	sincos
	mov	r2, r6
	mov	r3, r7
	add	r1, sp, #16
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	add	r5, sp, #24
	ldmia	r5, {r4-r5}
	bl	lroundf
	mov	r2, r6
	mov	r3, r7
	mov	r9, r0
	mov	r1, r5
	mov	r0, r4
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	lroundf
	ldr	r5, .L33+4
	mov	r4, r5
	mov	sl, r0
	ldmia	r4!, {r0, r1, r2, r3}
	add	ip, sp, #96
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r4!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r4, {r0, r1, r2, r3}
	add	r5, r5, #64
	stmia	ip, {r0, r1, r2, r3}
	ldmia	r5!, {r0, r1, r2, r3}
	add	ip, sp, #32
	stmia	ip!, {r0, r1, r2, r3}
	mov	r4, #20
	add	r6, sp, #160
	mla	r6, r4, fp, r6
	add	r7, sp, #160
	mla	r7, r4, r8, r7
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldmia	r5!, {r0, r1, r2, r3}
	stmia	ip!, {r0, r1, r2, r3}
	ldr	lr, [sp, #0]
	ldmia	r5, {r0, r1, r2, r3}
	add	r4, fp, r8, asl #2
	stmia	ip, {r0, r1, r2, r3}
	add	r8, r8, fp, asl #2
	add	r0, sp, #160
	rsb	r3, lr, #0
	ldr	lr, [sp, #4]
	add	ip, r0, r8, asl #2
	rsb	r5, sl, #0
	str	lr, [r6, #-128]
	ldr	r1, [sp, #12]
	str	r3, [ip, #-128]
	str	r9, [r6, #-64]
	str	r5, [ip, #-64]
	ldr	r3, [sp, #0]
	add	r4, r0, r4, asl #2
	str	r3, [r4, #-128]
	add	r0, sp, #96
	str	sl, [r4, #-64]
	str	lr, [r7, #-128]
	mov	r2, #0
	str	r9, [r7, #-64]
	bl	matrixMultiply
	ldr	r0, [sp, #12]
	add	r1, sp, #32
	mov	r2, #1
	bl	multiplyWithTransposed
	ldr	r0, [sp, #12]
	bl	apply_to_fixed_in_place
	add	sp, sp, #164
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L34:
	.align	2
.L33:
	.word	1082130432
	.word	.LANCHOR0
	.size	getSubMatrix, .-getSubMatrix
	.align	2
	.global	printMatrixArray
	.type	printMatrixArray, %function
printMatrixArray:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r7, r0
	mov	r6, r1
	mov	r8, r0, asl #2
	mov	r5, #0
	b	.L36
.L37:
	ldr	r1, [r6, r4, asl #2]
	bl	printf
	add	r4, r4, #1
.L39:
	cmp	r4, r7
	ldr	r0, .L41
	blt	.L37
	mov	r0, #10
	bl	putchar
	add	r5, r5, #1
	add	r6, r6, r8
.L36:
	cmp	r5, r7
	movlt	r4, #0
	blt	.L39
.L40:
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L42:
	.align	2
.L41:
	.word	.LC0
	.size	printMatrixArray, .-printMatrixArray
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, lr}
	ldr	ip, .L47
	sub	sp, sp, #68
	ldmia	ip!, {r0, r1, r2, r3}
	mov	lr, sp
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	mov	r0, #4
	mov	r1, sp
	bl	checkOffDiagonalZeros
	mov	r7, sp
	mov	r4, r0
	mov	r6, #0
	b	.L44
.L45:
	bl	getSubMatrix
	mov	r1, r4
	mov	r0, sp
	mov	r2, #2
	bl	getSubMatrix
	mov	r1, r4
	mov	r0, sp
	mov	r2, #3
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, #1
	mov	r2, #2
	bl	getSubMatrix
	mov	r0, sp
	mov	r1, #1
	mov	r2, #3
	bl	getSubMatrix
	mov	r2, #3
	mov	r0, sp
	mov	r1, #2
	bl	getSubMatrix
	mov	r1, r6
	ldr	r0, .L47+4
	bl	printf
	mov	r0, #4
	mov	r1, r7
	bl	checkOffDiagonalZeros
	mov	r4, r0
.L44:
	mov	r2, #1
	cmp	r4, #0
	mov	r1, r4
	add	r6, r6, r2
	mov	r5, sp
	mov	r0, sp
	beq	.L45
	mov	r1, sp
	mov	r0, #4
	bl	printMatrixArray
	mov	r0, #0
	add	sp, sp, #68
	ldmfd	sp!, {r4, r5, r6, r7, lr}
	bx	lr
.L48:
	.align	2
.L47:
	.word	.LANCHOR0+128
	.word	.LC1
	.size	main, .-main
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	C.28.2826, %object
	.size	C.28.2826, 64
C.28.2826:
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.type	C.29.2827, %object
	.size	C.29.2827, 64
C.29.2827:
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.word	0
	.word	0
	.word	0
	.word	0
	.word	511
	.type	C.30.2838, %object
	.size	C.30.2838, 64
C.30.2838:
	.word	31
	.word	77
	.word	-11
	.word	26
	.word	-42
	.word	14
	.word	79
	.word	-53
	.word	-68
	.word	-10
	.word	45
	.word	90
	.word	34
	.word	16
	.word	38
	.word	-19
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC0:
	.ascii	"%d \000"
.LC1:
	.ascii	"Iteration: %d\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
