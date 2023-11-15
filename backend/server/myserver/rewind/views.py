from django.shortcuts import render

# Create your views here.
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status, permissions
from .models import User
from .serializers import UserSerializer
from .userData import GetUserData

# class UserViewSet(viewsets.ModelViewSet):
#     serializer_class = UserSerializer
#     queryset = User.objects.all()

class IsReadyView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get(self, request, *args, **kwargs):
        '''
        Helper method to get the object with given user_id
        '''
        return Response({"isReady": True}, status=status.HTTP_200_OK)
        

class UserApiView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get_object(self, user_id):
        '''
        Helper method to get the object with given user_id
        '''
        try:
            return User.objects.get(id=user_id)
        except User.DoesNotExist:
            return None

    # 3. Retrieve
    def get(self, request, user_id, *args, **kwargs):
        '''
        Retrieves the UserInfo with given user id
        '''
#        user_id = request.data.get('user_id')
        user_instance = self.get_object(user_id) # or user_id
        if not user_instance:
            return Response(
                {"res": f"Object with {user_id} user id does not exists"},
                status=status.HTTP_400_BAD_REQUEST
            )

        user = {
                "id": user_instance.id,
                "name": user_instance.name,
                "country": user_instance.country,
                "birthdate": user_instance.birthdate,
                "balance": user_instance.balance,
                }
        response = GetUserData(user)
        return Response({"currentUser": response}, status=status.HTTP_200_OK)


    # 4. Update
    def put(self, request, user_id, *args, **kwargs):
        '''
        Updates the user item with given user id if exists
        '''
        user_instance = self.get_object(user_id)
        if not user_instance:
            return Response(
                {"res": f"Object with  {user_id}  todo id does not exists"}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        data = {
            'id': user_id,
            'name': request.data.get('name'), 
            'country': request.data.get('country'), 
            'birthdate': request.data.get('birthdate')
        }
        serializer = UserSerializer(instance = user_instance, data=data, partial = True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # 5. Delete
    def delete(self, request, user_id, *args, **kwargs):
        '''
        Deletes the todo item with given user_id if exists
        '''
        user_instance = self.get_object(user_id)
        if not user_instance:
            return Response(
                {"res": f"Object  with  {user_id}  todo id does not exists"}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        user_instance.delete()
        return Response(
            {"res": "Object deleted!"},
            status=status.HTTP_200_OK
        )