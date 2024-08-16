	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 1
	.eabi_attribute 18, 4
	.file	"matrixDiagV1.c"
	.global	__aeabi_dcmpgt
	.text
	.align	2
	.global	checkOffDiagonalZeros
	.type	checkOffDiagonalZeros, %function
checkOffDiagonalZeros:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	subs	r7, r0, #0
	ble	.L2
	mov	fp, r7, asl #3
	mov	sl, r1
	mov	r6, #0
	adr	r9, .L10
	ldmia	r9, {r8-r9}
	b	.L3
.L6:
	cmp	r6, r4
	beq	.L4
	ldmia	r5, {r0, r3}	@ phole ldm
	bic	r3, r3, #-2147483648
	mov	r1, r3
	mov	r2, r8
	mov	r3, r9
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	bne	.L5
.L4:
	add	r4, r4, #1
	add	r5, r5, #8
	cmp	r7, r4
	bgt	.L6
	add	r6, r6, #1
	add	sl, sl, fp
	cmp	r7, r6
	ble	.L2
.L3:
	mov	r5, sl
	mov	r4, #0
	b	.L6
.L5:
	mov	r0, #0
	b	.L7
.L2:
	mov	r0, #1
.L7:
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L11:
	.align	3
.L10:
	.word	-350469331
	.word	1058682594
	.size	checkOffDiagonalZeros, .-checkOffDiagonalZeros
	.align	2
	.global	transposeMatrix
	.type	transposeMatrix, %function
transposeMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	subs	r6, r0, #0
	movgt	r7, r6, asl #3
	movgt	sl, r1
	movgt	r8, #0
	movgt	r9, r2
	movgt	fp, r8
	bgt	.L14
	b	.L16
.L15:
	add	r2, r5, r1
	ldmia	r0!, {r3-r4}
	stmia	r2, {r3-r4}
	add	ip, ip, #1
	add	r1, r1, r7
	cmp	r6, ip
	bgt	.L15
	add	r8, r8, #1
	add	sl, sl, r7
	cmp	r6, r8
	ble	.L16
.L14:
	mov	r0, sl
	mov	r1, r9
	mov	ip, fp
	mov	r5, r8, asl #3
	b	.L15
.L16:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
	.size	transposeMatrix, .-transposeMatrix
	.align	2
	.global	copyMatrix
	.type	copyMatrix, %function
copyMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	mov	fp, r1
	mov	r9, r2
	subs	r5, r0, #0
	movgt	sl, r5, asl #3
	movgt	r8, #0
	movgt	r7, r8
	bgt	.L20
	b	.L22
.L21:
	add	r2, r6, ip
	add	r3, r0, ip
	ldmia	r3, {r3-r4}
	stmia	r2, {r3-r4}
	add	r1, r1, #1
	add	ip, ip, #8
	cmp	r5, r1
	bgt	.L21
	add	r8, r8, #1
	add	r7, r7, sl
	cmp	r5, r8
	ble	.L22
.L20:
	add	r6, r9, r7
	add	r0, fp, r7
	mov	r1, #0
	mov	ip, r1
	b	.L21
.L22:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
	.size	copyMatrix, .-copyMatrix
	.global	__aeabi_dmul
	.global	__aeabi_dadd
	.align	2
	.global	multiplyMatrices
	.type	multiplyMatrices, %function
multiplyMatrices:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #36
	str	r1, [sp, #20]
	str	r3, [sp, #16]
	subs	sl, r0, #0
	movgt	r9, sl, asl #3
	movgt	ip, r3
	movgt	r0, #0
	movgt	lr, r0
	movgt	r4, #0
	movgt	r5, #0
	bgt	.L26
	b	.L32
.L27:
	stmia	r1!, {r4-r5}
	add	r3, r3, #1
	cmp	sl, r3
	bgt	.L27
	add	r0, r0, #1
	add	ip, ip, r9
	cmp	sl, r0
	bgt	.L26
	mov	r3, #0
	str	r3, [sp, #28]
	str	r3, [sp, #24]
	str	r2, [sp, #8]
	mov	r2, #0
	str	r2, [sp, #4]
	b	.L28
.L26:
	mov	r1, ip
	mov	r3, lr
	b	.L27
.L29:
	add	r3, r8, r5
	ldmia	r7!, {r0-r1}
	ldmia	r3, {r2-r3}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	ldmia	r6, {r0-r1}
	bl	__aeabi_dadd
	stmia	r6, {r0-r1}
	add	r4, r4, #1
	add	r5, r5, r9
	cmp	sl, r4
	bgt	.L29
	add	fp, fp, #1
	add	r6, r6, #8
	cmp	sl, fp
	ble	.L30
.L31:
	ldmib	sp, {r4, r5, r7}	@ phole ldm
	mov	r8, fp, asl #3
	b	.L29
.L30:
	ldr	r3, [sp, #28]
	add	r3, r3, #1
	str	r3, [sp, #28]
	ldr	r2, [sp, #24]
	add	r2, r2, r9
	str	r2, [sp, #24]
	cmp	sl, r3
	ble	.L32
.L28:
	ldr	r2, [sp, #16]
	ldr	r3, [sp, #24]
	add	r6, r2, r3
	mov	fp, #0
	ldr	r2, [sp, #20]
	add	r3, r2, r3
	str	r3, [sp, #12]
	b	.L31
.L32:
	add	sp, sp, #36
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
	.size	multiplyMatrices, .-multiplyMatrices
	.global	__aeabi_dsub
	.global	__aeabi_ddiv
	.align	2
	.global	getSubMatrix
	.type	getSubMatrix, %function
getSubMatrix:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 968
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #972
	str	r0, [sp, #76]
	str	r1, [sp, #72]
	str	r2, [sp, #68]
	str	r3, [sp, #64]
	ldr	sl, [sp, #1008]
	mov	r0, r3, asl #5
	str	r0, [sp, #60]
	ldr	r1, [sp, #76]
	add	r2, r1, r0
	mov	r3, r3, asl #3
	str	r3, [sp, #56]
	add	r3, r2, r3
	ldmia	r3, {r0-r1}
	str	r0, [sp, #48]
	str	r1, [sp, #52]
	str	r0, [sp, #936]
	str	r1, [sp, #940]
	mov	r1, sl, asl #3
	str	r1, [sp, #44]
	add	r2, r2, r1
	ldmia	r2, {r3-r4}
	str	r3, [sp, #32]
	str	r4, [sp, #36]
	str	r3, [sp, #944]
	str	r4, [sp, #948]
	mov	r4, sl, asl #5
	str	r4, [sp, #28]
	ldr	r0, [sp, #76]
	add	r3, r0, r4
	ldr	r1, [sp, #56]
	add	r2, r3, r1
	ldmia	r2, {r4-r5}
	str	r4, [sp, #952]
	str	r5, [sp, #956]
	ldr	r2, [sp, #44]
	add	r3, r3, r2
	ldmia	r3, {r6-r7}
	str	r6, [sp, #960]
	str	r7, [sp, #964]
	mov	r0, r4
	mov	r1, r5
	add	r3, sp, #32
	ldmia	r3, {r2-r3}
	bl	__aeabi_dadd
	mov	r8, r0
	mov	r9, r1
	mov	r0, r6
	mov	r1, r7
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_dsub
	mov	r2, r0
	mov	r3, r1
	mov	r0, r8
	mov	r1, r9
	bl	__aeabi_ddiv
	bl	atan
	str	r0, [sp, #80]
	str	r1, [sp, #84]
	mov	r0, r4
	mov	r1, r5
	add	r3, sp, #32
	ldmia	r3, {r2-r3}
	bl	__aeabi_dsub
	mov	r4, r0
	mov	r5, r1
	mov	r0, r6
	mov	r1, r7
	add	r3, sp, #48
	ldmia	r3, {r2-r3}
	bl	__aeabi_dadd
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	bl	atan
	mov	r2, r0
	mov	r3, r1
	add	r1, sp, #80
	ldmia	r1, {r0-r1}
	bl	__aeabi_dsub
	mov	r2, #0
	mov	r3, #1069547520
	add	r3, r3, #2097152
	bl	__aeabi_dmul
	mov	r4, r0
	mov	r5, r1
	add	r6, sp, #96
	add	r7, sp, #88
	mov	r2, r6
	mov	r3, r7
	bl	sincos
	add	r9, sp, #88
	ldmia	r9, {r8-r9}
	ldr	fp, [sp, #96]
	ldr	r3, [sp, #100]
	str	r3, [sp, #4]
	add	r1, sp, #80
	ldmia	r1, {r0-r1}
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dsub
	mov	r2, r6
	mov	r3, r7
	bl	sincos
	add	r7, sp, #88
	ldmia	r7, {r6-r7}
	ldr	r4, [sp, #96]
	str	r4, [sp, #20]
	ldr	r0, [sp, #100]
	str	r0, [sp, #16]
	ldr	r1, [sp, #4]
	str	r1, [sp, #24]
	add	r2, r1, #-2147483648
	str	r2, [sp, #8]
	str	r8, [sp, #872]
	str	r9, [sp, #876]
	mov	r3, fp
	mov	r4, r2
	str	r3, [sp, #880]
	str	r4, [sp, #884]
	mov	r3, fp
	mov	r4, r1
	str	r3, [sp, #888]
	str	r4, [sp, #892]
	str	r8, [sp, #896]
	str	r9, [sp, #900]
	add	r5, sp, #904
	mov	r0, #2
	add	r1, sp, #872
	add	r2, sp, #936
	mov	r3, r5
	bl	multiplyMatrices
	str	r6, [sp, #872]
	str	r7, [sp, #876]
	ldr	r3, [sp, #20]
	ldr	r4, [sp, #16]
	str	r3, [sp, #880]
	str	r4, [sp, #884]
	ldr	r3, [sp, #16]
	add	r3, r3, #-2147483648
	str	r3, [sp, #12]
	ldr	r3, [sp, #20]
	ldr	r4, [sp, #12]
	str	r3, [sp, #888]
	str	r4, [sp, #892]
	str	r6, [sp, #896]
	str	r7, [sp, #900]
	mov	r0, #2
	mov	r1, r5
	add	r2, sp, #872
	add	r3, sp, #936
	bl	multiplyMatrices
	ldr	r5, .L38
	mov	r4, #128
	add	r0, sp, #744
	mov	r1, r5
	mov	r2, r4
	bl	memcpy
	add	r0, sp, #616
	add	r1, r5, r4
	mov	r2, r4
	bl	memcpy
	ldr	r4, [sp, #56]
	ldr	r0, [sp, #60]
	add	r3, r4, r0
	add	r1, sp, #968
	add	r0, r1, r3
	str	r8, [r0, #-224]
	str	r9, [r0, #-220]
	ldr	r2, [sp, #64]
	mov	r3, r2, asl #2
	add	r3, r3, sl
	add	ip, r1, r3, asl #3
	mov	r3, fp
	ldr	r4, [sp, #8]
	str	r3, [ip, #-224]
	str	r4, [ip, #-220]
	mov	sl, sl, asl #2
	add	sl, sl, r2
	add	r1, r1, sl, asl #3
	mov	r3, fp
	ldr	r4, [sp, #24]
	str	r3, [r1, #-224]
	str	r4, [r1, #-220]
	ldr	r3, [sp, #44]
	ldr	r4, [sp, #28]
	add	sl, r3, r4
	add	r3, sp, #968
	add	r2, r3, sl
	str	r8, [r2, #-224]
	str	r9, [r2, #-220]
	str	r6, [r0, #-352]
	str	r7, [r0, #-348]
	ldr	r3, [sp, #20]
	ldr	r4, [sp, #12]
	str	r3, [ip, #-352]
	str	r4, [ip, #-348]
	ldr	r3, [sp, #20]
	ldr	r4, [sp, #16]
	str	r3, [r1, #-352]
	str	r4, [r1, #-348]
	str	r6, [r2, #-352]
	str	r7, [r2, #-348]
	add	r5, sp, #488
	mov	r0, #4
	add	r1, sp, #744
	mov	r2, r5
	bl	transposeMatrix
	add	r6, sp, #360
	mov	r0, #4
	add	r1, sp, #616
	mov	r2, r6
	bl	transposeMatrix
	mov	r0, #4
	ldr	r1, [sp, #68]
	add	r2, sp, #232
	bl	transposeMatrix
	add	r4, sp, #104
	mov	r0, #4
	ldr	r1, [sp, #72]
	mov	r2, r5
	mov	r3, r4
	bl	multiplyMatrices
	mov	r0, #4
	mov	r1, r4
	ldr	r2, [sp, #72]
	bl	copyMatrix
	mov	r0, #4
	add	r1, sp, #744
	ldr	r2, [sp, #76]
	mov	r3, r4
	bl	multiplyMatrices
	mov	r0, #4
	mov	r1, r4
	mov	r2, r6
	ldr	r3, [sp, #76]
	bl	multiplyMatrices
	mov	r0, #4
	add	r1, sp, #616
	ldr	r2, [sp, #68]
	mov	r3, r4
	bl	multiplyMatrices
	mov	r0, #4
	mov	r1, r4
	ldr	r2, [sp, #68]
	bl	copyMatrix
	add	sp, sp, #972
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L39:
	.align	2
.L38:
	.word	.LANCHOR0
	.size	getSubMatrix, .-getSubMatrix
	.align	2
	.global	freeMatrix
	.type	freeMatrix, %function
freeMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	mov	r4, r0
	ldr	r0, [r0, #0]
	bl	free
	ldr	r0, [r4, #4]
	bl	free
	ldr	r0, [r4, #8]
	bl	free
	ldr	r0, [r4, #12]
	bl	free
	mov	r0, r4
	bl	free
	ldmfd	sp!, {r4, lr}
	bx	lr
	.size	freeMatrix, .-freeMatrix
	.align	2
	.global	createIdentityMatrix
	.type	createIdentityMatrix, %function
createIdentityMatrix:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r6, r0
	mov	r4, r0
	mov	r0, r0, asl #2
	bl	malloc
	mov	r5, r0
	mov	r9, r0
	cmp	r6, #0
	ble	.L43
	mov	r7, r6, asl #3
	mov	r4, #0
.L44:
	mov	r0, r7
	bl	malloc
	str	r0, [r5, r4, asl #2]
	add	r4, r4, #1
	cmp	r6, r4
	bgt	.L44
	mov	r0, #0
	mov	ip, r0
	mov	r4, r0
	mov	r7, #0
	mov	r8, #0
	mov	sl, #0
	mov	fp, #1069547520
	add	fp, fp, #3145728
	b	.L45
.L48:
	cmp	r0, r1
	ldreq	r3, [r5, ip]
	addeq	r3, r3, lr
	stmeqia	r3, {sl-fp}
.L46:
	ldrne	r3, [r5, ip]
	movne	r2, r1, asl #3
	addne	r3, r3, r2
	stmneia	r3, {r7-r8}
.L47:
	add	r1, r1, #1
	cmp	r6, r1
	bgt	.L48
	add	r0, r0, #1
	add	ip, ip, #4
	cmp	r6, r0
	ble	.L43
.L45:
	mov	lr, r0, asl #3
	mov	r1, r4
	b	.L48
.L43:
	mov	r0, r9
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
	.size	createIdentityMatrix, .-createIdentityMatrix
	.align	2
	.global	printMatrixArray
	.type	printMatrixArray, %function
printMatrixArray:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	subs	r6, r0, #0
	movgt	r9, r6, asl #3
	movgt	sl, r1
	movgt	r8, #0
	ldrgt	r7, .L58
	movgt	fp, #10
	bgt	.L54
	b	.L56
.L55:
	mov	r0, r7
	ldmia	r5!, {r2-r3}
	bl	printf
	add	r4, r4, #1
	cmp	r6, r4
	bgt	.L55
	mov	r0, fp
	bl	putchar
	add	r8, r8, #1
	add	sl, sl, r9
	cmp	r6, r8
	ble	.L56
.L54:
	mov	r5, sl
	mov	r4, #0
	b	.L55
.L56:
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L59:
	.align	2
.L58:
	.word	.LC0
	.size	printMatrixArray, .-printMatrixArray
	.global	__aeabi_i2d
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 392
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #404
	bl	clock
	str	r0, [sp, #12]
	ldr	r4, .L65
	add	r6, sp, #272
	mov	r5, #128
	mov	r0, r6
	add	r1, r4, #256
	mov	r2, r5
	bl	memcpy
	add	r0, sp, #144
	add	r1, r4, #384
	mov	r2, r5
	bl	memcpy
	add	r0, sp, #16
	add	r1, r4, #512
	mov	r2, r5
	bl	memcpy
	mov	r0, #4
	mov	r1, r6
	bl	checkOffDiagonalZeros
	cmp	r0, #0
	bne	.L61
	mov	r7, #0
	add	r4, sp, #272
	add	r6, sp, #144
	add	r5, sp, #16
	mov	fp, #1
	mov	r9, r7
	mov	sl, #2
	mov	r8, #3
.L62:
	str	fp, [sp, #0]
	mov	r0, r4
	mov	r1, r6
	mov	r2, r5
	mov	r3, r9
	bl	getSubMatrix
	str	sl, [sp, #0]
	mov	r0, r4
	mov	r1, r6
	mov	r2, r5
	mov	r3, r9
	bl	getSubMatrix
	str	r8, [sp, #0]
	mov	r0, r4
	mov	r1, r6
	mov	r2, r5
	mov	r3, r9
	bl	getSubMatrix
	str	sl, [sp, #0]
	mov	r0, r4
	mov	r1, r6
	mov	r2, r5
	mov	r3, fp
	bl	getSubMatrix
	str	r8, [sp, #0]
	mov	r0, r4
	mov	r1, r6
	mov	r2, r5
	mov	r3, fp
	bl	getSubMatrix
	str	r8, [sp, #0]
	mov	r0, r4
	mov	r1, r6
	mov	r2, r5
	mov	r3, sl
	bl	getSubMatrix
	add	r7, r7, #1
	ldr	r0, .L65+4
	mov	r1, r7
	bl	printf
	mov	r0, #4
	mov	r1, r4
	bl	checkOffDiagonalZeros
	cmp	r0, #0
	beq	.L62
.L61:
	mov	r0, #4
	add	r1, sp, #272
	bl	printMatrixArray
	bl	clock
	ldr	r3, [sp, #12]
	rsb	r0, r3, r0
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1090519040
	add	r3, r3, #3047424
	add	r3, r3, #1152
	bl	__aeabi_ddiv
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L65+8
	bl	printf
	mov	r0, #0
	add	sp, sp, #404
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L66:
	.align	2
.L65:
	.word	.LANCHOR0
	.word	.LC1
	.word	.LC2
	.size	main, .-main
	.section	.rodata
	.align	3
.LANCHOR0 = . + 0
	.type	C.69.3194, %object
	.size	C.69.3194, 128
C.69.3194:
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.type	C.70.3195, %object
	.size	C.70.3195, 128
C.70.3195:
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.type	C.72.3210, %object
	.size	C.72.3210, 128
C.72.3210:
	.word	0
	.word	1077870592
	.word	0
	.word	1079197696
	.word	0
	.word	-1071251456
	.word	0
	.word	1077542912
	.word	0
	.word	-1069219840
	.word	0
	.word	1076625408
	.word	0
	.word	1079230464
	.word	0
	.word	-1068859392
	.word	0
	.word	-1068433408
	.word	0
	.word	-1071382528
	.word	0
	.word	1078362112
	.word	0
	.word	1079410688
	.word	0
	.word	1078001664
	.word	0
	.word	1076887552
	.word	0
	.word	1078132736
	.word	0
	.word	-1070399488
	.type	C.73.3211, %object
	.size	C.73.3211, 128
C.73.3211:
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.type	C.74.3212, %object
	.size	C.74.3212, 128
C.74.3212:
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%f \000"
.LC1:
	.ascii	"Iteration: %d\012\000"
	.space	1
.LC2:
	.ascii	"Execution time: %f seconds\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
