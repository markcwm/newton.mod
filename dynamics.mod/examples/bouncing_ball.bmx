' bouncing_ball.bmx
' basic example with force and torque callback

SuperStrict

Framework Openb3dmax.B3dglgraphics
Import Newton.Dynamics
Import Brl.Standardio

Main()


Function Main()

	' init scene
	Graphics3D DesktopWidth(),DesktopHeight(),0,2
	
	Local cam:TCamera = CreateCamera()
	PositionEntity cam,0,5,-20
	
	Local light:TLight = CreateLight()
	
	Local ball:TMesh = CreateSphere()
	EntityColor ball,200,100,100
	
	Local plane:TMesh = CreatePlane()
	EntityColor plane,0,200,100
		
	' Create a newton world
	Local world:TNWorld = TNWorld.Create()
	
	' Create a static body to serve as the floor.
	Local matrix:TNMatrix = New TNMatrix
	Local background:TNBody = CreateBackgroundBody(world)
	Local freeFallBall:TNBody = CreateFreeFallBall(world,1) ' 2nd parameter changes freefall method
	
	' For deterministic behavior call this method each time you change the world
	world.InvalidateCache()
	
	While Not KeyHit(KEY_ESCAPE)
		world.Update(1.0/60.0)
		freeFallBall.GetMatrix(matrix)
		
		PositionEntity ball,matrix.positX,matrix.positY,matrix.positZ
		
		RenderWorld
		
		Text 0,20,"x="+matrix.positX+" y="+matrix.positY+" z="+matrix.positZ
		Text 0,40,"Memory: "+GCMemAlloced()
		
		Flip
		GCCollect
	Wend
	
	' destroy the newton world
	world.Destroy()
	
	End
	
End Function

Function CreateBackgroundBody:TNBody(world:TNWorld)

	Local points:Float[] = [ ..
		-100.0, 0.0, 100.0, ..
		100.0, 0.0, 100.0, .. 
		100.0, 0.0, -100.0, ..
		-100.0, 0.0, -100.0 ]
		
	' create a collision tree
	Local tree:TNTreeCollision = world.CreateTreeCollision(0)
	
	' start building the collision mesh
	tree.BeginBuild()
	
	' add the face one at a time
	tree.AddFace(4, points, 12, 0)
	
	' finish building the collision
	tree.EndBuild(1)
	
	' Create a body with a collision and locate at the identity matrix position 
	Local matrix:TNMatrix = TNMatrix.GetIdentityMatrix()
	Local body:TNBody = world.CreateDynamicBody(tree, matrix)
	
	' do not forget to destroy the collision after you no longer need it
	tree.Destroy()
	Return body
	
End Function

Function CreateFreeFallBall:TNBody(world:TNWorld,freefall:Int=True)

	' create a collision sphere
	Local sphere:TNCollision = world.CreateSphere(1.0, 0, Null)
	
	' Create a dynamic body with a sphere shape, and 
	Local matrix:TNMatrix = TNMatrix.GetIdentityMatrix()
	matrix.positY = 20.0
	
	Local ballfree:TFreeFallBall = New TFreeFallBall
	Local ball:TNBody = New TNBody
	If freefall=True
		
	' set the force callback for applying the force and torque
		world.CreateDynamicBody(sphere, matrix, ballfree)
		
		' set the mass for this body
		Local mass:Float = 2.0
		ballfree.SetMassProperties(mass, sphere)
		
		' set the linear damping to zero
		ballfree.SetLinearDamping(0.0)
		
	Else ' standard callback method
		
		ball = world.CreateDynamicBody(sphere, matrix, Null)
		ball.SetForceAndTorqueCallback(ApplyGravity)
		
		' set the mass for this body
		Local mass:Float = 20.0
		ball.SetMassProperties(mass, sphere)
		
		ball.SetLinearDamping(0.0)
	EndIf
	
	' do not forget to destroy the collision after you no longer need it
	sphere.Destroy()
	
	If freefall=True
		Return ballfree
	Else
		Return ball
	EndIf
	
End Function

' callbacks are for sending newton data, each callback has a specific set of parameters
Function ApplyGravity(body:TNBody, timestep:Float, threadIndex:Int)

	' apply gravity force to the body
	Local mass:Float
	Local Ixx:Float
	Local Iyy:Float
	Local Izz:Float
	
	body.GetMassMatrix(mass, Ixx, Iyy, Izz)
	body.SetForce(0, -9.8 * mass, 0.0, 0.0)
	
End Function

Type TFreeFallBall Extends TNBody

	' this allows you to override callbacks depending on type
	Method OnForceAndTorque(timestamp:Float, threadIndex:Int)
	
		' apply gravity force to the body
		Local mass:Float
		Local Ixx:Float
		Local Iyy:Float
		Local Izz:Float
		
		GetMassMatrix(mass, Ixx, Iyy, Izz)
		SetForce(0, -9.8 * mass, 0.0, 0.0)
		
	End Method

End Type
