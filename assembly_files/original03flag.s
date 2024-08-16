	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
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
	subs	sl, r0, #0
	movgt	r9, r1
	movgt	fp, sl, asl #3
	movgt	r8, #0
	ble	.L2
.L3:
	mov	r7, r9
	mov	r6, #0
.L6:
	cmp	r8, r6
	adr	r3, .L11
	ldmia	r3, {r2-r3}
	add	r6, r6, #1
	beq	.L4
	ldmia	r7, {r0, r1}	@ phole ldm
	bic	r1, r1, #-2147483648
	mov	r4, r0
	mov	r5, r1
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	bne	.L5
.L4:
	cmp	sl, r6
	add	r7, r7, #8
	bgt	.L6
	add	r8, r8, #1
	cmp	sl, r8
	add	r9, r9, fp
	bgt	.L3
.L2:
	mov	r0, #1
	b	.L7
.L5:
	mov	r0, #0
.L7:
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L12:
	.align	3
.L11:
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
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
	subs	r6, r0, #0
	mov	r9, r2
	movgt	sl, r1
	movgt	r7, r6, asl #3
	movgt	r8, #0
	ble	.L17
.L15:
	mov	r4, sl
	mov	r0, r9
	mov	ip, #0
	mov	r5, r8, asl #3
.L16:
	add	ip, ip, #1
	ldmia	r4!, {r1-r2}
	add	r3, r5, r0
	cmp	r6, ip
	stmia	r3, {r1-r2}
	add	r0, r0, r7
	bgt	.L16
	add	r8, r8, #1
	cmp	r6, r8
	add	sl, sl, r7
	bgt	.L15
.L17:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl}
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
	subs	r6, r0, #0
	movgt	r8, #0
	mov	fp, r1
	mov	r9, r2
	movgt	sl, r6, asl #3
	movgt	r7, r8
	ble	.L23
.L21:
	mov	r0, #0
	add	r5, r9, r7
	add	r4, fp, r7
	mov	ip, r0
.L22:
	add	r3, r4, ip
	ldmia	r3, {r1-r2}
	add	r0, r0, #1
	add	r3, r5, ip
	cmp	r6, r0
	stmia	r3, {r1-r2}
	add	ip, ip, #8
	bgt	.L22
	add	r8, r8, #1
	cmp	r6, r8
	add	r7, r7, sl
	bgt	.L21
.L23:
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
	subs	r9, r0, #0
	sub	sp, sp, #36
	str	r1, [sp, #8]
	str	r2, [sp, #4]
	str	r3, [sp, #0]
	movgt	fp, r9, asl #3
	movgt	lr, r3
	movgt	ip, #0
	movgt	r0, #0
	movgt	r1, #0
	ble	.L34
.L27:
	mov	r2, lr
	mov	r3, #0
.L28:
	add	r3, r3, #1
	cmp	r9, r3
	stmia	r2!, {r0-r1}
	bgt	.L28
	add	ip, ip, #1
	cmp	r9, ip
	add	lr, lr, fp
	bgt	.L27
	mov	r2, #0
	str	r2, [sp, #28]
	str	r2, [sp, #20]
	mov	r3, r2
.L33:
	ldr	r2, [sp, #8]
	add	r3, r2, r3
	str	r3, [sp, #12]
	ldr	r2, [sp, #0]
	ldr	r3, [sp, #20]
	add	r3, r2, r3
	str	r3, [sp, #16]
	mov	r3, #0
	str	r3, [sp, #24]
.L31:
	ldr	r2, [sp, #16]
	ldr	r3, [sp, #24]
	ldmia	r2, {r4-r5}
	ldr	r8, [sp, #12]
	ldr	r7, [sp, #4]
	mov	r6, #0
	mov	sl, r3, asl #3
.L30:
	add	r1, sl, r7
	ldmia	r1, {r2-r3}
	ldmia	r8!, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dadd
	add	r6, r6, #1
	cmp	r9, r6
	mov	r4, r0
	mov	r5, r1
	add	r7, r7, fp
	bgt	.L30
	ldr	r3, [sp, #16]
	ldr	r2, [sp, #24]
	stmia	r3!, {r4-r5}
	add	r2, r2, #1
	cmp	r9, r2
	str	r2, [sp, #24]
	str	r3, [sp, #16]
	bgt	.L31
	ldr	r2, [sp, #28]
	ldr	r3, [sp, #20]
	add	r2, r2, #1
	add	r3, r3, fp
	cmp	r9, r2
	str	r2, [sp, #28]
	str	r3, [sp, #20]
	bgt	.L33
.L34:
	add	sp, sp, #36
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
	.size	multiplyMatrices, .-multiplyMatrices
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
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r5, r0
	mov	r0, r0, asl #2
	bl	malloc
	cmp	r5, #0
	mov	sl, r0
	ble	.L43
	mov	r6, r5, asl #3
	mov	r4, #0
.L44:
	mov	r0, r6
	bl	malloc
	str	r0, [sl, r4, asl #2]
	add	r4, r4, #1
	cmp	r5, r4
	bgt	.L44
	mov	r9, #1069547520
	mov	r1, #0
	mov	r6, #0
	mov	r7, #0
	mov	r8, #0
	add	r9, r9, #3145728
.L48:
	ldr	r2, [sl, r1, asl #2]
	mov	r3, r1, asl #3
	add	r0, r2, r3
	mov	r3, #0
	b	.L47
.L45:
	add	r3, r3, #1
	cmp	r5, r3
	stmia	r2, {r6-r7}
	add	r2, r2, #8
	ble	.L53
.L47:
	cmp	r1, r3
	bne	.L45
	add	r3, r3, #1
	cmp	r5, r3
	stmia	r0, {r8-r9}
	add	r2, r2, #8
	bgt	.L47
.L53:
	add	r1, r1, #1
	cmp	r5, r1
	bgt	.L48
.L43:
	mov	r0, sl
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
	.size	createIdentityMatrix, .-createIdentityMatrix
	.align	2
	.global	printMatrixArray
	.type	printMatrixArray, %function
printMatrixArray:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	subs	r6, r0, #0
	movgt	r8, r1
	movgt	sl, r6, asl #3
	movgt	r7, #0
	ble	.L58
.L56:
	mov	r5, r8
	mov	r4, #0
.L57:
	add	r4, r4, #1
	ldr	r0, .L60
	ldmia	r5!, {r2-r3}
	bl	printf
	cmp	r6, r4
	bgt	.L57
	add	r7, r7, #1
	mov	r0, #10
	bl	putchar
	cmp	r6, r7
	add	r8, r8, sl
	bgt	.L56
.L58:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L61:
	.align	2
.L60:
	.word	.LC0
	.size	printMatrixArray, .-printMatrixArray
	.global	__aeabi_dsub
	.global	__aeabi_ddiv
	.align	2
	.global	getSubMatrix
	.type	getSubMatrix, %function
getSubMatrix:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 888
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #892
	str	r3, [sp, #64]
	ldr	r5, [sp, #64]
	ldr	r6, [sp, #928]
	str	r0, [sp, #76]
	mov	r3, r3, asl #5
	ldr	r4, [sp, #928]
	mov	r5, r5, asl #3
	add	r0, r0, r3
	mov	r6, r6, asl #3
	ldr	r9, [sp, #76]
	mov	r4, r4, asl #5
	str	r6, [sp, #24]
	add	ip, r0, r6
	add	r0, r0, r5
	ldmia	ip, {r6-r7}
	ldr	sl, [sp, #24]
	ldmia	r0, {fp-ip}
	str	r3, [sp, #20]
	add	r3, r9, r4
	add	lr, r3, r5
	ldmia	lr, {r8-r9}
	str	fp, [sp, #80]
	str	ip, [sp, #84]
	add	r3, r3, sl
	ldmia	r3, {sl-fp}
	str	r4, [sp, #16]
	str	r5, [sp, #28]
	add	r5, sp, #80
	ldmia	r5, {r4-r5}
	mov	r3, r9
	str	r1, [sp, #72]
	str	r2, [sp, #68]
	mov	r0, r6
	mov	r2, r8
	mov	r1, r7
	str	r4, [sp, #856]
	str	r5, [sp, #860]
	str	r6, [sp, #864]
	str	r7, [sp, #868]
	str	r8, [sp, #872]
	str	r9, [sp, #876]
	str	sl, [sp, #880]
	str	fp, [sp, #884]
	bl	__aeabi_dadd
	add	r3, sp, #80
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	mov	r0, sl
	mov	r1, fp
	bl	__aeabi_dsub
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	bl	atan
	mov	r2, r6
	str	r0, [sp, #88]
	str	r1, [sp, #92]
	mov	r3, r7
	mov	r0, r8
	mov	r1, r9
	bl	__aeabi_dsub
	mov	r2, sl
	mov	r4, r0
	mov	r5, r1
	mov	r3, fp
	add	r1, sp, #80
	ldmia	r1, {r0-r1}
	bl	__aeabi_dadd
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_ddiv
	bl	atan
	mov	r2, r0
	mov	r3, r1
	add	r1, sp, #88
	ldmia	r1, {r0-r1}
	bl	__aeabi_dsub
	mov	r3, #1069547520
	mov	r2, #0
	add	r3, r3, #2097152
	bl	__aeabi_dmul
	add	r6, sp, #144
	add	r7, sp, #136
	mov	r5, r1
	mov	r2, r6
	mov	r3, r7
	mov	r4, r0
	bl	sincos
	ldr	r9, [sp, #148]
	mov	r3, r5
	ldr	r5, [sp, #144]
	mov	r2, r4
	add	r1, sp, #88
	ldmia	r1, {r0-r1}
	str	r5, [sp, #60]
	str	r9, [sp, #56]
	bl	__aeabi_dsub
	add	fp, sp, #136
	ldmia	fp, {sl-fp}
	mov	r2, r6
	mov	r3, r7
	str	sl, [sp, #104]
	str	fp, [sp, #108]
	bl	sincos
	add	r2, sp, #56
	ldmia	r2, {r2, r3}	@ phole ldm
	mov	r5, r3
	mov	r7, r3
	mov	r8, r2
	add	r3, sp, #104
	ldmia	r3, {r2-r3}
	add	fp, r9, #-2147483648
	mov	r6, fp
	add	ip, sp, #144
	ldmia	ip, {ip, lr}	@ phole ldm
	str	r2, [sp, #792]
	str	r3, [sp, #796]
	str	r2, [sp, #816]
	str	r3, [sp, #820]
	add	r4, sp, #136
	ldmia	r4, {r3-r4}
	str	r5, [sp, #800]
	str	r6, [sp, #804]
	str	r7, [sp, #808]
	str	r8, [sp, #812]
	add	r5, sp, #856
	str	r3, [sp, #96]
	str	r4, [sp, #100]
	str	fp, [sp, #40]
	add	r4, sp, #792
	str	ip, [sp, #52]
	str	lr, [sp, #48]
	str	r5, [sp, #12]
	str	r4, [sp, #8]
	add	r9, sp, #824
	mov	r3, #0
	mov	r4, #0
	mov	r6, r5
.L63:
	stmia	r9, {r3-r4}
	str	r3, [r9, #8]
	str	r4, [r9, #12]
	add	r9, r9, #16
	cmp	r9, r6
	bne	.L63
	add	sl, sp, #824
	add	r8, sp, #792
	add	fp, sp, #872
.L64:
	mov	r7, sl
	add	r6, sp, #856
.L66:
	ldmia	r6, {r2-r3}
	ldmia	r8, {r0-r1}
	bl	__aeabi_dmul
	ldmia	r7, {r2-r3}
	bl	__aeabi_dadd
	add	r3, r6, #16
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r8, #8
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dadd
	add	r6, r6, #8
	cmp	r6, fp
	stmia	r7!, {r0-r1}
	bne	.L66
	add	sl, sl, #16
	cmp	sl, r9
	add	r8, r8, #16
	bne	.L64
	ldr	r9, [sp, #48]
	ldr	r1, [sp, #52]
	ldr	r2, [sp, #48]
	add	r9, r9, #-2147483648
	add	fp, sp, #96
	ldmia	fp, {sl-fp}
	mov	r8, r9
	mov	r5, r1
	mov	r6, r2
	mov	r7, r1
	str	r5, [sp, #800]
	str	r6, [sp, #804]
	str	r7, [sp, #808]
	str	r8, [sp, #812]
	str	sl, [sp, #792]
	str	fp, [sp, #796]
	str	sl, [sp, #816]
	str	fp, [sp, #820]
	str	r9, [sp, #44]
	mov	r3, #0
	add	r9, sp, #856
	mov	r4, #0
.L68:
	stmia	r9, {r3-r4}
	str	r3, [r9, #8]
	str	r4, [r9, #12]
	add	fp, sp, #888
	add	r9, r9, #16
	cmp	r9, fp
	bne	.L68
	add	sl, sp, #856
	add	r8, sp, #824
	add	fp, sp, #808
.L69:
	mov	r7, sl
	add	r6, sp, #792
.L71:
	ldmia	r6, {r2-r3}
	ldmia	r8, {r0-r1}
	bl	__aeabi_dmul
	ldmia	r7, {r2-r3}
	bl	__aeabi_dadd
	add	r3, r6, #16
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r8, #8
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dadd
	add	r6, r6, #8
	cmp	r6, fp
	stmia	r7!, {r0-r1}
	bne	.L71
	add	sl, sl, #16
	cmp	sl, r9
	add	r8, r8, #16
	bne	.L69
	add	ip, sp, #664
	ldr	r1, .L121
	mov	r2, #128
	add	r0, sp, #664
	str	ip, [sp, #4]
	bl	memcpy
	ldr	r1, .L121+4
	mov	r2, #128
	add	r0, sp, #536
	bl	memcpy
	ldr	lr, [sp, #928]
	ldr	r9, [sp, #28]
	mov	ip, lr, asl #2
	ldr	fp, [sp, #20]
	ldr	lr, [sp, #64]
	add	sl, r9, fp
	add	ip, ip, lr
	ldr	fp, [sp, #24]
	ldr	lr, [sp, #16]
	ldr	r3, [sp, #64]
	add	r9, fp, lr
	ldr	fp, [sp, #928]
	mov	r0, r3, asl #2
	add	r0, r0, fp
	add	r4, sp, #40
	ldmia	r4, {r4, r6}	@ phole ldm
	add	fp, sp, #888
	add	lr, fp, sl
	ldr	r1, [sp, #60]
	add	sl, sp, #888
	ldr	r7, [sp, #52]
	ldr	r2, [sp, #56]
	ldr	r8, [sp, #48]
	add	fp, fp, r0, asl #3
	add	r0, sl, ip, asl #3
	add	ip, sl, r9
	mov	sl, r4
	mov	r4, r6
	add	r6, sp, #96
	ldmia	r6, {r5-r6}
	str	r1, [sp, #32]
	str	r2, [sp, #36]
	mov	r9, r1
	mov	r3, r7
	mov	r2, r8
	mov	r1, r7
	str	r5, [lr, #-352]
	str	r6, [lr, #-348]
	str	r3, [fp, #-352]
	str	r4, [fp, #-348]
	str	r1, [r0, #-352]
	str	r2, [r0, #-348]
	add	r3, sp, #104
	ldmia	r3, {r2-r3}
	str	r2, [lr, #-224]
	str	r3, [lr, #-220]
	add	r4, sp, #32
	ldmia	r4, {r3-r4}
	str	r5, [ip, #-352]
	str	r6, [ip, #-348]
	str	r9, [fp, #-224]
	str	sl, [fp, #-220]
	str	r3, [r0, #-224]
	str	r4, [r0, #-220]
	add	r5, sp, #104
	ldmia	r5, {r4-r5}
	str	r4, [ip, #-224]
	str	r5, [ip, #-220]
	ldr	r5, [sp, #8]
	add	r0, sp, #664
	add	ip, sp, #408
.L73:
	ldmia	r0, {r3-r4}
	stmia	ip, {r3-r4}
	add	r2, r0, #8
	ldmia	r2, {r1-r2}
	str	r1, [ip, #32]
	str	r2, [ip, #36]
	add	r4, r0, #16
	ldmia	r4, {r3-r4}
	str	r3, [ip, #64]
	str	r4, [ip, #68]
	add	r2, r0, #24
	ldmia	r2, {r1-r2}
	add	r0, r0, #32
	cmp	r0, r5
	str	r1, [ip, #96]
	str	r2, [ip, #100]
	add	ip, ip, #8
	bne	.L73
	add	r6, sp, #280
	str	r6, [sp, #0]
	ldr	r9, [sp, #4]
	add	r0, sp, #536
	add	ip, sp, #280
.L74:
	ldmia	r0, {r3-r4}
	stmia	ip, {r3-r4}
	add	r2, r0, #8
	ldmia	r2, {r1-r2}
	str	r1, [ip, #32]
	str	r2, [ip, #36]
	add	r4, r0, #16
	ldmia	r4, {r3-r4}
	str	r3, [ip, #64]
	str	r4, [ip, #68]
	add	r2, r0, #24
	ldmia	r2, {r1-r2}
	add	r0, r0, #32
	cmp	r0, r9
	str	r1, [ip, #96]
	str	r2, [ip, #100]
	add	ip, ip, #8
	bne	.L74
	add	sl, sp, #152
	str	sl, [sp, #128]
	ldr	lr, [sp, #0]
	mov	r9, sl
	mov	r3, #0
	mov	r4, #0
.L75:
	stmia	r9, {r3-r4}
	str	r3, [r9, #8]
	str	r4, [r9, #12]
	str	r3, [r9, #16]
	str	r4, [r9, #20]
	str	r3, [r9, #24]
	str	r4, [r9, #28]
	add	r9, r9, #32
	cmp	r9, lr
	bne	.L75
	ldr	ip, [sp, #128]
	ldr	fp, [sp, #72]
	str	ip, [sp, #124]
	str	fp, [sp, #132]
	mov	r7, fp
	mov	sl, ip
	add	fp, sp, #440
.L76:
	mov	r8, sl
	add	r6, sp, #408
.L78:
	ldmia	r6, {r2-r3}
	ldmia	r7, {r0-r1}
	bl	__aeabi_dmul
	ldmia	r8, {r2-r3}
	bl	__aeabi_dadd
	add	r3, r6, #32
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #8
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dadd
	add	r3, r6, #64
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #16
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dadd
	add	r3, r6, #96
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #24
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dadd
	add	r6, r6, #8
	cmp	r6, fp
	stmia	r8!, {r0-r1}
	bne	.L78
	add	sl, sl, #32
	cmp	sl, r9
	add	r7, r7, #32
	bne	.L76
	add	r2, sp, #128
	ldmia	r2, {r2, sl}	@ phole ldm
	str	r2, [sp, #120]
	mov	r0, r2
.L80:
	add	r2, r0, #8
	ldmia	r2, {r1-r2}
	ldr	r3, [sp, #132]
	ldmia	r0, {r5-r6}
	str	r1, [r3, #8]
	str	r2, [r3, #12]
	add	r4, r0, #16
	ldmia	r4, {r3-r4}
	str	r3, [sl, #16]
	str	r4, [sl, #20]
	add	r2, r0, #24
	ldmia	r2, {r1-r2}
	add	r0, r0, #32
	stmia	sl, {r5-r6}
	str	r1, [sl, #24]
	str	r2, [sl, #28]
	cmp	r9, r0
	add	sl, sl, #32
	str	sl, [sp, #132]
	bne	.L80
	ldr	r3, [sp, #128]
	mov	r1, #0
	mov	r2, #0
.L81:
	stmia	r3, {r1-r2}
	str	r1, [r3, #8]
	str	r2, [r3, #12]
	str	r1, [r3, #16]
	str	r2, [r3, #20]
	str	r1, [r3, #24]
	str	r2, [r3, #28]
	add	r3, r3, #32
	cmp	r9, r3
	bne	.L81
	ldr	ip, [sp, #76]
	ldr	fp, [sp, #128]
	add	r7, sp, #664
	add	sl, ip, #32
.L82:
	ldr	lr, [sp, #76]
	str	lr, [sp, #116]
	mov	r8, fp
	mov	r6, lr
.L84:
	ldmia	r6, {r2-r3}
	ldmia	r7, {r0-r1}
	bl	__aeabi_dmul
	ldmia	r8, {r2-r3}
	bl	__aeabi_dadd
	add	r3, r6, #32
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #8
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dadd
	add	r3, r6, #64
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #16
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dadd
	add	r3, r6, #96
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #24
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dadd
	add	r6, r6, #8
	cmp	r6, sl
	stmia	r8!, {r0-r1}
	bne	.L84
	add	fp, fp, #32
	cmp	r9, fp
	add	r7, r7, #32
	bne	.L82
	ldr	r0, [sp, #76]
	mov	r3, #0
	add	r2, r0, #128
	mov	r4, #0
.L86:
	stmia	r0, {r3-r4}
	str	r3, [r0, #8]
	str	r4, [r0, #12]
	str	r3, [r0, #16]
	str	r4, [r0, #20]
	str	r3, [r0, #24]
	str	r4, [r0, #28]
	add	r0, r0, #32
	cmp	r0, r2
	bne	.L86
	ldr	r7, [sp, #128]
	add	sl, sp, #312
.L87:
	ldr	r8, [sp, #116]
	add	r6, sp, #280
.L89:
	ldmia	r6, {r2-r3}
	ldmia	r7, {r0-r1}
	bl	__aeabi_dmul
	ldmia	r8, {r2-r3}
	bl	__aeabi_dadd
	add	r3, r6, #32
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #8
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dadd
	add	r3, r6, #64
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #16
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dadd
	add	r3, r6, #96
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #24
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dadd
	add	r6, r6, #8
	cmp	r6, sl
	stmia	r8!, {r0-r1}
	bne	.L89
	ldr	r2, [sp, #116]
	add	r7, r7, #32
	add	r2, r2, #32
	cmp	r9, r7
	str	r2, [sp, #116]
	bne	.L87
	ldr	r5, [sp, #128]
	mov	r3, #0
	mov	r4, #0
.L98:
	stmia	r5, {r3-r4}
	str	r3, [r5, #8]
	str	r4, [r5, #12]
	str	r3, [r5, #16]
	str	r4, [r5, #20]
	str	r3, [r5, #24]
	str	r4, [r5, #28]
	add	r5, r5, #32
	cmp	r5, r9
	str	r5, [sp, #128]
	bne	.L98
	ldr	r3, [sp, #68]
	add	r7, sp, #536
	add	sl, r3, #32
.L92:
	ldr	fp, [sp, #68]
	ldr	r8, [sp, #124]
	mov	r6, fp
.L94:
	ldmia	r6, {r2-r3}
	ldmia	r7, {r0-r1}
	bl	__aeabi_dmul
	ldmia	r8, {r2-r3}
	bl	__aeabi_dadd
	add	r3, r6, #32
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #8
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dadd
	add	r3, r6, #64
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #16
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r4
	mov	r1, r5
	bl	__aeabi_dadd
	add	r3, r6, #96
	ldmia	r3, {r2-r3}
	mov	r4, r0
	mov	r5, r1
	add	r1, r7, #24
	ldmia	r1, {r0-r1}
	bl	__aeabi_dmul
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dadd
	add	r6, r6, #8
	cmp	r6, sl
	stmia	r8!, {r0-r1}
	bne	.L94
	ldr	r6, [sp, #124]
	add	r6, r6, #32
	cmp	r6, r9
	str	r6, [sp, #124]
	add	r7, r7, #32
	bne	.L92
.L97:
	ldr	sl, [sp, #120]
	add	r2, sl, #8
	ldmia	r2, {r1-r2}
	ldmia	sl, {r5-r6}
	str	r1, [fp, #8]
	str	r2, [fp, #12]
	add	r4, sl, #16
	ldmia	r4, {r3-r4}
	str	r3, [fp, #16]
	str	r4, [fp, #20]
	add	r2, sl, #24
	ldmia	r2, {r1-r2}
	add	sl, sl, #32
	cmp	r9, sl
	stmia	fp, {r5-r6}
	str	r1, [fp, #24]
	str	r2, [fp, #28]
	str	sl, [sp, #120]
	add	fp, fp, #32
	bne	.L97
	add	sp, sp, #892
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L122:
	.align	2
.L121:
	.word	.LANCHOR0
	.word	.LANCHOR0+128
	.size	getSubMatrix, .-getSubMatrix
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
	add	fp, sp, #272
	str	r0, [sp, #12]
	ldr	r1, .L141+8
	mov	r2, #128
	add	r9, sp, #144
	mov	r0, fp
	bl	memcpy
	add	sl, sp, #16
	ldr	r1, .L141+12
	mov	r2, #128
	mov	r0, r9
	bl	memcpy
	mov	r0, sl
	ldr	r1, .L141+16
	mov	r2, #128
	bl	memcpy
	add	r6, sp, #296
	mov	r7, #0
.L124:
	cmp	r7, #0
	adr	r3, .L141
	ldmia	r3, {r2-r3}
	beq	.L127
	sub	r0, r6, #24
	ldmia	r0, {r0, r1}	@ phole ldm
	bic	r1, r1, #-2147483648
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	bne	.L125
	cmp	r7, #1
	beq	.L128
.L127:
	sub	r2, r6, #16
	ldmia	r2, {r2, r3}	@ phole ldm
	bic	r3, r3, #-2147483648
	mov	r0, r2
	mov	r1, r3
	adr	r3, .L141
	ldmia	r3, {r2-r3}
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	bne	.L125
	cmp	r7, #2
	beq	.L129
.L128:
	ldmdb	r6, {r2, r3}	@ phole ldm
	bic	r3, r3, #-2147483648
	mov	r0, r2
	mov	r1, r3
	mov	r5, r3
	adr	r3, .L141
	ldmia	r3, {r2-r3}
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	bne	.L125
	cmp	r7, #3
	beq	.L126
.L129:
	ldmia	r6, {r2, r3}	@ phole ldm
	bic	r3, r3, #-2147483648
	mov	r0, r2
	mov	r1, r3
	mov	r5, r3
	adr	r3, .L141
	ldmia	r3, {r2-r3}
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	add	r7, r7, #1
	add	r6, r6, #32
	bne	.L125
	cmp	r7, #4
	bne	.L124
.L126:
	mov	r4, fp
.L135:
	ldmia	r4, {r2-r3}
	ldr	r0, .L141+20
	bl	printf
	add	r3, r4, #8
	ldmia	r3, {r2-r3}
	ldr	r0, .L141+20
	bl	printf
	add	r3, r4, #16
	ldmia	r3, {r2-r3}
	ldr	r0, .L141+20
	bl	printf
	add	r3, r4, #24
	ldmia	r3, {r2-r3}
	ldr	r0, .L141+20
	bl	printf
	mov	r0, #10
	bl	putchar
	add	r4, r4, #32
	add	r3, sp, #400
	cmp	r4, r3
	bne	.L135
	bl	clock
	ldr	ip, [sp, #12]
	rsb	r0, ip, r0
	bl	__aeabi_i2d
	mov	r3, #1090519040
	add	r3, r3, #3047424
	mov	r2, #0
	add	r3, r3, #1152
	bl	__aeabi_ddiv
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L141+24
	bl	printf
	mov	r0, #0
	add	sp, sp, #404
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L125:
	mov	r8, #0
.L140:
	mov	ip, #1
	mov	r0, fp
	mov	r1, r9
	mov	r2, sl
	mov	r3, #0
	str	ip, [sp, #0]
	bl	getSubMatrix
	mov	ip, #2
	mov	r0, fp
	mov	r1, r9
	mov	r2, sl
	mov	r3, #0
	str	ip, [sp, #0]
	bl	getSubMatrix
	mov	ip, #3
	mov	r0, fp
	mov	r1, r9
	mov	r2, sl
	mov	r3, #0
	str	ip, [sp, #0]
	bl	getSubMatrix
	mov	ip, #2
	mov	r0, fp
	mov	r1, r9
	mov	r2, sl
	mov	r3, #1
	str	ip, [sp, #0]
	bl	getSubMatrix
	mov	ip, #3
	mov	r0, fp
	mov	r1, r9
	mov	r2, sl
	mov	r3, #1
	str	ip, [sp, #0]
	add	r8, r8, #1
	bl	getSubMatrix
	mov	ip, #3
	mov	r0, fp
	mov	r1, r9
	mov	r2, sl
	mov	r3, #2
	str	ip, [sp, #0]
	bl	getSubMatrix
	ldr	r0, .L141+28
	mov	r1, r8
	bl	printf
	add	r6, sp, #296
	mov	r7, #0
.L130:
	cmp	r7, #0
	adr	r3, .L141
	ldmia	r3, {r2-r3}
	beq	.L132
	sub	r0, r6, #24
	ldmia	r0, {r0, r1}	@ phole ldm
	bic	r1, r1, #-2147483648
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	bne	.L140
	cmp	r7, #1
	beq	.L133
.L132:
	sub	r2, r6, #16
	ldmia	r2, {r2, r3}	@ phole ldm
	bic	r3, r3, #-2147483648
	mov	r0, r2
	mov	r1, r3
	adr	r3, .L141
	ldmia	r3, {r2-r3}
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	bne	.L140
	cmp	r7, #2
	beq	.L134
.L133:
	ldmdb	r6, {r2, r3}	@ phole ldm
	bic	r3, r3, #-2147483648
	mov	r0, r2
	mov	r1, r3
	mov	r5, r3
	adr	r3, .L141
	ldmia	r3, {r2-r3}
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	bne	.L140
	cmp	r7, #3
	beq	.L126
.L134:
	ldmia	r6, {r2, r3}	@ phole ldm
	bic	r3, r3, #-2147483648
	mov	r0, r2
	mov	r1, r3
	mov	r5, r3
	adr	r3, .L141
	ldmia	r3, {r2-r3}
	bl	__aeabi_dcmpgt
	cmp	r0, #0
	add	r7, r7, #1
	add	r6, r6, #32
	bne	.L140
	cmp	r7, #4
	bne	.L130
	b	.L126
.L142:
	.align	3
.L141:
	.word	-350469331
	.word	1058682594
	.word	.LANCHOR0+256
	.word	.LANCHOR0+384
	.word	.LANCHOR0+512
	.word	.LC0
	.word	.LC2
	.word	.LC1
	.size	main, .-main
	.section	.rodata
	.align	3
.LANCHOR0 = . + 0
	.type	C.75.3200, %object
	.size	C.75.3200, 128
C.75.3200:
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
	.type	C.76.3201, %object
	.size	C.76.3201, 128
C.76.3201:
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
	.type	C.97.3235, %object
	.size	C.97.3235, 128
C.97.3235:
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
	.type	C.98.3236, %object
	.size	C.98.3236, 128
C.98.3236:
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
	.type	C.99.3237, %object
	.size	C.99.3237, 128
C.99.3237:
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
